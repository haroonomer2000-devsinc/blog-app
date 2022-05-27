# frozen_string_literal: true

class LikePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    @user.id == @record.user_id
  end

  def edit?
    update?
  end

  def update?
    @user.id == @record.user_id
  end

  def destroy?
    @user.id == @record.user_id
  end
end
