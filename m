Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38C221288DC
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Dec 2019 12:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfLULeh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Dec 2019 06:34:37 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50902 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfLULeh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Dec 2019 06:34:37 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so5304715pjb.0
        for <linux-ext4@vger.kernel.org>; Sat, 21 Dec 2019 03:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=tFHBLDmUFkbld6WxKvLD5qto3/rPkNsHbIZafhsnJM4=;
        b=Xb7gO56DB8GSYC+ydlBr0GYAAhVFNf/p3DrEJFFevqlFpMbinP4gqFNus6ia80e4D5
         e6d/nOrLkAFh9mFaq+/o0Bft9TUQ8TjJ9vG3nr/Nau6rr6QGWBo0AYDahjnKArzFYiQB
         RjPms110oBCAna7qypheBxZGQqd/VKbrYuvxGtOGo+qIOEVsgnrkqwjgfvwxqQWvYMFD
         a7FHRHphxuSwnOB21jAn8MXPYlqH3x7AnhsJJer5oPtkVHJak+W3C54l7cYN3IQuslQ5
         9O4AUd+3bvfUJCD7ScCd28SHd59iJTGw4isP2BiBsi8lCgOG8/j6266QKL6l8CqXJMRJ
         sXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tFHBLDmUFkbld6WxKvLD5qto3/rPkNsHbIZafhsnJM4=;
        b=GotQchtjMQCXrmK0r5uhysOS3tXlWawfT/BrgzHLelP85/QHLB/5XySoWP4nE5EYIz
         abRCgZhKl27Cl/87sxZYCm1U6UhgPF2L3T0ioSmfUYah9EMttc9NtJQNiD8OHpDN6x38
         HJ6si+mOcoy1iGcNcbnHSWXD+F+RBJLzP7G0DUydmK6hThl1wK9A5rAmzbOQWjjDxt50
         8LXlWCkoJkfvQSpuB/c1MpTcyhOhnaGwxuC/3iITrtVfLjdeZRmg8jGlJJQm4lj52IPO
         IfX0eFPqM/6JEJvkNskrHiM5Pb6UN1gSp1gj4tOC+V76UW5hj+M20AGVCXK+QBGmHb1d
         foDQ==
X-Gm-Message-State: APjAAAXU3ex4GMLGs9PVohPbGyW+29JzsSnDAPSn7mfhHeBfPxqmwqcN
        5otPj6gCoXmGBCfVKaTLPrte3L2v
X-Google-Smtp-Source: APXvYqwKkzliQrSdFhQ3cTp6d/RiCoooIXBTnp13tUfzYiHQSDWuoYrUn44X7TmqSs9rmwvBfTB43g==
X-Received: by 2002:a17:902:409:: with SMTP id 9mr20754093ple.245.1576928076182;
        Sat, 21 Dec 2019 03:34:36 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m71sm16405944pje.0.2019.12.21.03.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 03:34:35 -0800 (PST)
Date:   Sat, 21 Dec 2019 19:34:28 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: ensure revoke credits when set xattr
Message-ID: <20191221105508.nrvonawwtz5a6bfz@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It is possible that we need to release and forget blocks
during set xattr block, especially with 128 inode size,
so we need enough revoke credits to do that. Or we'll
hit WARNING since commit:
	[83448bd] ext4: Reserve revoke credits for freed blocks

This can be triggered easily in a kinda corner case:
--------------

namegen()
{
	echo "fstest_`dd if=/dev/urandom bs=1k count=1 2>/dev/null | md5sum  | cut -c -10`"
}

md0="/`namegen`"
d0=`namegen`
d1=`namegen`
d2=`namegen`

fallocate -l 200m test.img
mkfs.ext4 -F -b 4096 -I 128 test.img
mkdir -p $md0
mount -o loop test.img $md0 || exit
pushd $md0

mkdir ${d0}
setfacl -d -m 'u::rwx' ${d0}
mkdir ${d0}/${d1} # hit warning
echo $?
mkdir ${d0}/${d2}
rm -rf ${d0}

popd
umount -d $md0
rm -rf $md0 test.img
--------------

Which is derived from the pjd test suite[1].

Patch tested by xfstests auto group.

[1] https://sourceforge.net/p/ntfs-3g/pjd-fstest/ci/master/tree/

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 fs/ext4/xattr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 8966a54..5c32c54 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2319,6 +2319,12 @@ static struct buffer_head *ext4_xattr_get_block(struct inode *inode)
 			error = -ENOSPC;
 			goto cleanup;
 		}
+		error = ext4_journal_ensure_credits(handle, credits,
+				ext4_trans_default_revoke_credits(inode->i_sb));
+		if (error < 0) {
+			EXT4_ERROR_INODE(inode, "ensure credits (error %d)", error);
+			goto cleanup;
+		}
 	}
 
 	error = ext4_reserve_inode_write(handle, inode, &is.iloc);
-- 
1.8.3.1
