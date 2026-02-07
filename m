Return-Path: <linux-ext4+bounces-13614-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE8PMUXBhml1QgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13614-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 05:36:21 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCD6104EC2
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 05:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90D61301876E
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Feb 2026 04:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55BA2D7DF8;
	Sat,  7 Feb 2026 04:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdD91u52"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF462C3251
	for <linux-ext4@vger.kernel.org>; Sat,  7 Feb 2026 04:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770438975; cv=none; b=ZwY8iUtuIrfTYehtqJiqkqPG61UZUG2291u92NR4XeO0c9tFFTXB7FfkqxSHx6YY9ENQmu3cG+EZOxbdI5u1OcoByjV8R0lXuVZ5rS8peD8CXld/1ttkB6t9XO/VmGnjGdf/SXwfhmYBFmAZOeHYyNGKeYPz6Ip0b5EFOHePALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770438975; c=relaxed/simple;
	bh=LOu565aMnPMalQFcSP7BM4GVOKkia4TKLD4EhGhjiTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5cNY/8Iz7yk4X2zj8RP7jMItrUGBuQS77A8oq9Rg1nKPysm2oXn0a+z+/5rOqX/tJGrCRN23fLrTuCm7TKHca08sCNwJbZ7vEoIe9PohXJ0atf3F6+Mc0pL8V5AMyLOwsS2PLNeaR+dWW13Xm6kbYxwiV5uk0QBWc39hk0jOiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdD91u52; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3530e7b3dc2so2379923a91.3
        for <linux-ext4@vger.kernel.org>; Fri, 06 Feb 2026 20:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770438975; x=1771043775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u6l+ANQIq478T27+r1YavztrZap8Og8nO5Z+UVtAbxQ=;
        b=RdD91u52+o7laG2vt5S7yErCUvgqEW17oS2gjhdVjgUZms7YRVod3kJ91Lruj3a9xR
         LJmelpPhLgC7fjvQr8XDYjS9EDl+uM26+95mTqOfw2ouzgSQ/gX4R0zrhiXcRVe2b3KN
         CHrScDT9CEw+IwuByYK47W/YbSbdJ9i3VZlBuxzw/sVMbwyRuS+BvlfTiLSgoP7DL7f/
         31AzXnRoIj8/6GEv3qTl5KAI5K+13iG27o4G1EHdhbUTydOKevmdrHv6WWq0YYq25uLR
         SpkcBfP7N4Wj1P0rvXIFv7ZIxPy/vayV6L7VYQh7u3JRqcnTVD+LIcw94jnfoUxXOCLS
         w2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770438975; x=1771043775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6l+ANQIq478T27+r1YavztrZap8Og8nO5Z+UVtAbxQ=;
        b=NW6ou1BsbJE5Tsajol1r/t2NOMStob9oDgWe+xTs9Y5qVznZ5yJRqGCGcUxHVDMjdn
         hWfyIUU4Yfs/Pt7PvGlFL7ayTwavV1LijT/8ld+L7J5cyT4799STnWsunS52gfHCr1W7
         zj5MZ728/G4DyBrAs/BTIAwQf25JzptkZ2GsVYFYUFbKT6/cxPXRnze4hiZLf/6IzQIo
         7/eCicIw4bruGLE+QqI/XSvpfigomQoBCSN/MOgEsTA6vqB53r9y+QeY8Kh1mD9NYzlV
         ybiPv+aOeYvtHB5g9OoLTy8dvnGpq9/RD5E7zCmCIBs5OZqPEQnd/G9AEjInw/+U2vEi
         FOcQ==
X-Gm-Message-State: AOJu0YxAMKatVTd6tCJ4AYP5SvzXyCGGRsWZ/061anVO1MKLFB3vsqRi
	SRVWYEKt5mbuAd6qqQtyuVi0en46aKg9pvBQOpzcRc/ya2cXivAyAbNr
X-Gm-Gg: AZuq6aI2EYaV/scour6xdZTA63fSmEx8CElHBER7l8CCmRgvImKMpsLJQ9Js9NGW7cL
	azDZDtWCkpywsa98vScSPseM82O82z0/lFbUy5UTez4sz/PepINvXUSlYsMtmRRhXqscXpSgSFA
	sD306pisjiSddg4g1WVsvv1KNf9sayXnibjnAiWWmknOsBivns3HwnSz75fjpjnzdFqT16pU1c1
	CMG+hOgVwVrYbq9qSdizGo0O9Tl/h8VWJWCuJ00DXFk06QT6rHESWqoy9QcViuiFk1yelxX7E/U
	e66qkcU2YxRg1akpEKnQNecudqkm7Bt+EIWFCNde0oe8pa/4c0bdsGN1UBZRMbnut4lNqTwsXv2
	VlxU5CRPXHu7HjtpKPlDIhJXZjfR9+H3C/LXLBcCLon3KxYcgkxHQjahhAbz9bhyklgeWY2dElg
	ZUmBj4e4NRDdn7sXBjVHvbmrG6+M/PTUBLGGGzeTHiGuhRcvhcByVq0wksLNekNI8BxdI=
X-Received: by 2002:a17:90b:5348:b0:34a:b4a2:f0c8 with SMTP id 98e67ed59e1d1-354b3e5c2f9mr3893129a91.30.1770438974808;
        Fri, 06 Feb 2026 20:36:14 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:7e49:7e31:b8c9:621a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354c02a7ad6sm1011537a91.2.2026.02.06.20.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 20:36:14 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+7de5fe447862fc37576f@syzkaller.appspotmail.com,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: [PATCH] ext4: convert inline data to extents when truncate exceeds inline size
Date: Sat,  7 Feb 2026 10:06:07 +0530
Message-ID: <20260207043607.1175976-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13614-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4,7de5fe447862fc37576f];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CCD6104EC2
X-Rspamd-Action: no action

Add a check in ext4_setattr() to convert files from inline data storage
to extent-based storage when truncate() grows the file size beyond the
inline capacity. This prevents the filesystem from entering an
inconsistent state where the inline data flag is set but the file size
exceeds what can be stored inline.

Without this fix, the following sequence causes a kernel BUG_ON():

1. Mount filesystem with inode that has inline flag set and small size
2. truncate(file, 50MB) - grows size but inline flag remains set
3. sendfile() attempts to write data
4. ext4_write_inline_data() hits BUG_ON(write_size > inline_capacity)

The crash occurs because ext4_write_inline_data() expects inline storage
to accommodate the write, but the actual inline capacity (~60 bytes for
i_block + ~96 bytes for xattrs) is far smaller than the file size and
write request.

The fix checks if the new size from setattr exceeds the inode's actual
inline capacity (EXT4_I(inode)->i_inline_size) and converts the file to
extent-based storage before proceeding with the size change.

This addresses the root cause by ensuring the inline data flag and file
size remain consistent during truncate operations.

Reported-by: syzbot+7de5fe447862fc37576f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7de5fe447862fc37576f
Tested-by: syzbot+7de5fe447862fc37576f@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
 fs/ext4/inode.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0c466ccbed69..c3dc0422ff95 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5901,6 +5901,18 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (attr->ia_size == inode->i_size)
 			inc_ivers = false;
 
+		/*
+		 * If file has inline data but new size exceeds inline capacity,
+		 * convert to extent-based storage first to prevent inconsistent
+		 * state (inline flag set but size exceeds inline capacity).
+		 */
+		if (ext4_has_inline_data(inode) &&
+		    attr->ia_size > EXT4_I(inode)->i_inline_size) {
+			error = ext4_convert_inline_data(inode);
+			if (error)
+				goto err_out;
+		}
+
 		if (shrink) {
 			if (ext4_should_order_data(inode)) {
 				error = ext4_begin_ordered_truncate(inode,
-- 
2.43.0


