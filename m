Return-Path: <linux-ext4+bounces-4002-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09BC967652
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Sep 2024 13:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F64B21353
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Sep 2024 11:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64D7166F28;
	Sun,  1 Sep 2024 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="y3wgtqPK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C63114E2D6;
	Sun,  1 Sep 2024 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725191932; cv=none; b=YLZLS3FuYmmrM71shnrRVyCCiXjW3aI5QOXHu9d4E3Q1Sf/Sg1ZFFyk//2dbuk38HaCHXBwQ4j2BBXLp2K8wBlWoklq32BoxAIySvzp5zw5E5FGsqq19ZBRrcBitvhCJUbliQszpNK2hYzFpq17j6Y6K7Cu+/tz8z3B/daUY9V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725191932; c=relaxed/simple;
	bh=o25NKNSrHHZV1fIePXff0OJ75WE9t4tgDtvOssqOd9E=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=KfDcdkF4TVOKfTsLtKJp9LEf5hRzFTe8dhKi0JFjeBxObPUHmiTTeu8pzdYwsyPdEEmjTAY2kb0TMrgy2XPak5ZoyXPLO52Y2qKcP94Pg6h6CXA7Ym2HeSxNw9JMf26TBYklO4ZTkwmGuxhvLP2AUJLVCa/qd0u/mhgTloz796g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=y3wgtqPK; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725191918; bh=nHPmW1vEyKjrjnt56kVG9uG3tYA+W6mHHeHkcXDud5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=y3wgtqPKj9YzVA5dvUUoz6inlNnW3ytr6Vs18j+5w/mnwnRhC9aEa8kfXoBJbl2Rn
	 OGULmoXK6Dz3cmX7VsTKy3KdLksMIe/iVjwE/k+5Q/qyGOjb251dID7tUjCJDrE+D9
	 o8UznxgUaX6YiGGYxDqrNx6DRCzPPm38PeK9gq6w=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id D1B12C0B; Sun, 01 Sep 2024 19:52:27 +0800
X-QQ-mid: xmsmtpt1725191547tinvcqjw8
Message-ID: <tencent_27C9A8AECAEEFD8C8FA7E286C892D0865106@qq.com>
X-QQ-XMAILINFO: N55MlACpQQDvkEDNB1weEDpNidStvUCUa8LATl4jqTsGYuZ2C6NobANlkWCQwP
	 d0KsVYYG1fJK8TgTUKT4C1uTJ3R41KRWF70UOTcAlyUbdI8x2OVPBLKxOr5xvv/uSdLW3d4DcWCm
	 HdjuwehkTY6S0pTVLJfJF8oMXAjc0Rlg+ZrCJ4jfUdY1ZkV6OPgM/M6CYWl85F3kJSWvVKfx9n6S
	 iNJ5euo2rkL8WiC4XYhxd9Qpv9PIOg1SRIJ5B0TQ135KRSMMqRLhfq70ms4YmkMjxYfivGl3OjXC
	 ovB0a1XSdHhYKoLMovYTqGB6nUwWYyol0BMMjNm4LLORWeDvALInu9uX1wjKu6d71ajHmbwyFZrn
	 6ZjtilVxdaCLJdonMb8sPEiTMtEjeKKUSH92woq9oIyQHLnbx8LLwPTFaNXAefkEnGLDQ3pY+Bxg
	 VWjN+AjKBCxJEjFKd3Ms0SuVBe+gjwAhPmpuxco4z2WRVDhvhAzNJd19QeLrSUu4XYu76qBAu5vy
	 ZsxRZfRujZ/ZT7n9ThsxsG9IZGxYrAhv39oj0av6R9IcrBDM6B4wW6Jz77NKL2UQMjEkzqrHEE/O
	 XvXj7a6bpHMVUd6USZRJn10r6xIpG4q3Q7Tv+0mbGlithZrsE//wsT4MbPBPAKgZVgMoeN6EBnHN
	 X3KaV8IgZRXRwyzRA7vyH3uh5Lo+FlmJk2Vxmph7keqm6tBrKr+RthrCZQ3821kYLgQneXHfsNp8
	 y5j5FsWr0z/6nyKyiDcvQQJ2O5U/vQwudyA6YQ89DTwnW6Z2K2Oz1YnAY5MFqbcrrZf1II6Jp0i/
	 XYknje4MyUAtCenonRGTYfHa23UbXYUL5LdRMWMG4i1gGM4rW4iaEW+V/kkGUzDkVD+0xqI5iuQq
	 W8IGZTOvGHAFbDczhk9ZlT3mUvfk9hYAWLU9Gj0epCoWJ89hA/LITFhy086ZAYNw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8aa6090cbe3c97dc9565@syzkaller.appspotmail.com
Cc: adilger.kernel@dilger.ca,
	jack@suse.cz,
	libaokun1@huawei.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ritesh.list@gmail.com,
	syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_inline_data_truncate
Date: Sun,  1 Sep 2024 19:52:27 +0800
X-OQ-MSGID: <20240901115226.2302454-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <000000000000a0ed7b062109d3da@google.com>
References: <000000000000a0ed7b062109d3da@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use EXT4_INODE_HAS_XATTR_SPACE to check the existence of xattr space,
before clear the content in the xattr space

#syz test

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index e7a09a99837b..b568232ab871 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1946,7 +1946,8 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 			ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
 
 		/* Clear the content in the xattr space. */
-		if (inline_size > EXT4_MIN_INLINE_DATA_SIZE) {
+		if (inline_size > EXT4_MIN_INLINE_DATA_SIZE &&
+		    EXT4_INODE_HAS_XATTR_SPACE(inode)) {
 			if ((err = ext4_xattr_ibody_find(inode, &i, &is)) != 0)
 				goto out_error;
 


