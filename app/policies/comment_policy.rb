# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    destroy?
  end

  def edit?
    update?
  end

  def update?
    @user.id != @record.user_id
  end

  def destroy?
    @user.id == @record.user_id
  end
end
