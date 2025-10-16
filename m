Return-Path: <linux-ext4+bounces-10893-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7C6BE44E6
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBF73A9745
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 15:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA64339B5C;
	Thu, 16 Oct 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqzSMI+r"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF28345743
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629203; cv=none; b=Z/NONFo6AKE5SzYpGILt84F1hpyfDm+wXRPLS0WWV+n06mIsvTsUgl9TjR4ayPQpvcSgiZcBl+kQ5wzmwVvkBI5X4+NxFJ3+vyiM44WUUUmIVly2nl9L1X8cuXX7scsG0i4wTAUu5KaqIvKj6xbGvHEjz4rylsO/4WAFtZkIS5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629203; c=relaxed/simple;
	bh=P1wbexoAwbFRPJanzU7YyH2WhQRvq2OoAaqs4IGA0oY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPlTRIvf1smKTrawPc+/MbnRY7QFL5YlZtmxzHo/RZOxD5HpmhLJF5JoK/fE757uPzv8jHj+c1k40y++zpevKT5Rkle0/Yov/c0rTOIeLD3BVnDHoqVnmL7/IaK3CygxUcqz7GFBadoPrIReRdmDKkpY7IrVU17Oxl3C6hIw65U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqzSMI+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589D0C4CEF1;
	Thu, 16 Oct 2025 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629203;
	bh=P1wbexoAwbFRPJanzU7YyH2WhQRvq2OoAaqs4IGA0oY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AqzSMI+rutnr1sJW7R8mOjlOu+DXLGcAqRD56BRQWDQyCJXJVNqp6pIj0gZcNx2A6
	 otlPfRmJDXltsg1k/sCAysXHGE+oD9P/vHZX5d7N6Qot1+uJnhYTW7IHr0flfhbkof
	 BY3QaMw9K7ESkLn7NQyUg/qHZkqSs72+GWgwIOK0e/5NYNjoLXdrIvdWJA4MOMYhR8
	 CHUY5QkpIPXaX1hKkR+FEYzg5CZJD+uo7gOWHs/rFRlgErVfszn40dJSAOJvgDzfDD
	 OV5O418SNnPlhdeDADZVZVI/GfpXxk1hvEDiSOFdPtyOGNhhBtmIDvpvYbHpRug/fs
	 Bd0EJ8+rVBX6w==
Date: Thu, 16 Oct 2025 08:40:02 -0700
Subject: [PATCH 01/16] debian/rules: remove extra pkg-config
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176062915483.3343688.17108550511096524632.stgit@frogsfrogsfrogs>
In-Reply-To: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
References: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Not sure why the definition for deb_udevudevdir calls pkg-config with
the string "pkg-config" as its first argument.  Even more crazily, this
happens on Debian 12:

$ pkg-config --variable=udevdir udev
/lib/udev
$ pkg-config pkg-config --variable=udevdir udev
 /lib/udev

Note the leading space!  Given the sed script in the same definition,
I'm guessing that the extra space is NOT the desired behavior.

Cc: <linux-ext4@vger.kernel.org> # v1.47.1
Fixes: 288de9fb396811 ("debian: acknowledge NMU'ed changes to 1.47.0-2.4")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 debian/rules |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/debian/rules b/debian/rules
index 4cb80652115317..c88675c9228bd0 100755
--- a/debian/rules
+++ b/debian/rules
@@ -16,7 +16,7 @@ endif
 
 ifeq ($(DEB_HOST_ARCH_OS), linux)
 export deb_systemdsystemunitdir = $(shell pkg-config --variable=systemdsystemunitdir systemd | sed s,^/,,)
-export deb_udevudevdir = $(shell pkg-config pkg-config --variable=udevdir udev | sed s,^/,,)
+export deb_udevudevdir = $(shell pkg-config --variable=udevdir udev | sed s,^/,,)
 endif
 
 ifneq ($(filter pkg.e2fsprogs.no-fuse2fs,$(DEB_BUILD_PROFILES)),)


