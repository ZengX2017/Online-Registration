"""empty message

Revision ID: a5df1e46f3a5
Revises: 2d8fd02c15c0
Create Date: 2018-03-09 14:07:57.022592

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = 'a5df1e46f3a5'
down_revision = '2d8fd02c15c0'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint('trinfo_ibfk_4', 'trinfo', type_='foreignkey')
    op.drop_column('trinfo', 'user_id')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('trinfo', sa.Column('user_id', mysql.INTEGER(display_width=11), autoincrement=False, nullable=True))
    op.create_foreign_key('trinfo_ibfk_4', 'trinfo', 'user', ['user_id'], ['id'], ondelete='CASCADE')
    # ### end Alembic commands ###
