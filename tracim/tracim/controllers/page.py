import os

import tg
from io import BytesIO
from preview_generator.manager import PreviewManager
from tg import expose, tmpl_context
from tracim.controllers import TIMRestController
from tracim.lib.content import ContentApi
from tracim.model.data import ContentType

__all__ = ['PagesController']

class PagesController(TIMRestController):

    @expose()
    def _default(self):
        return '<h2> Error Loading Page</h2>'

    @expose()
    def get_all(self, *args, **kwargs):
        file_id = int(tg.request.controller_state.routing_args.get('file_id'))
        print('all the pages of document {}'.format(file_id))
        return 'all the pages of document {}'.format(file_id)

    @expose(content_type='image/jpeg')
    def get_one(self, page_id, *args, **kwargs):
        file_id = int(tg.request.controller_state.routing_args.get('file_id'))
        user = tmpl_context.current_user
        content_api = ContentApi(
            user,
            show_archived=True,
            show_deleted=True,
        )
        file_content = content_api.get_one(file_id, self._item_type).file_content
        file_name = content_api.get_one(file_id, self._item_type).file_name
        cache_path = '/home/alexis/Pictures/cache/'
        file = BytesIO()
        file.write(file_content)
        with open('{}{}'.format(cache_path, file_name), 'wb') as temp_file:
            file.seek(0, 0)
            buffer = file.read(1024)
            while buffer:
                temp_file.write(buffer)
                buffer = file.read(1024)

        preview_manager = PreviewManager(cache_path, create_folder=True)
        path = preview_manager.get_jpeg_preview(
            file_path='/home/alexis/Pictures/cache/{}'.format(file_name),
            height=1000,
            width=1000,
            page=page_id,
        )
        
        try:
            os.remove('{}{}'.format(cache_path, file_name))
        except OSError:
            pass

        with open(path, 'rb') as large:
            return large.read()



    @property
    def _item_type(self):
        return ContentType.File