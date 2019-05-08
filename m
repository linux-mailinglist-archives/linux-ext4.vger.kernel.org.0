Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACB58180D5
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2019 22:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfEHUIa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 May 2019 16:08:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34193 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfEHUI3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 May 2019 16:08:29 -0400
Received: by mail-io1-f68.google.com with SMTP id g84so10162835ioa.1;
        Wed, 08 May 2019 13:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fO0KWnimMpo8SBCLE4EyOOofpfWQrLjsWFfvlM20p+U=;
        b=dYd+rQORDN+M7OSLpC0QH70WCdWVklZkT/b9XrcsRudrPsK1e/WSGZwJ2fPkwhMWBj
         8LWikOVzwnBKBt0kF6yhfvOLSlMVgiL6MuVwWZM9l76xFLsmh1N844gqH7rj27Nsb9e4
         iFUwF3gRpRdj1Q0DGPMmuvxd1kELfqwqSUYFdmMNqRHOTs7KVVNUwfwEt9tXgOzGip0m
         t+S67L0sEvyKsge6zq9pnIjINxq/96ioroRl+K4tj4ReIH6Md0WuFHN/jU/ppim8VeDk
         StgIXhUWzrKLLls8Tj0WiiBCNfMobIrg1K8WnQiG6i6sn1HijIAeR8RhZeXwy41I1tin
         C9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fO0KWnimMpo8SBCLE4EyOOofpfWQrLjsWFfvlM20p+U=;
        b=QEdQ/4x/QlmtJUjU4HhfX4Wt8pJP0Lq+iPt04z2W8LnLjo3wFeQDGEBpvVSO3e+Z3N
         jGbpdX/2sQuRNCQ4t96AGlyg0YHc+2YYLhdJ/+/KU7KSjfzRQ0Sf8PdD48wXoSR5gv1z
         NJMvPmkOf2xhp5abSm3mKHVQbddHBuhJpjGIIguobedE4Qw2w1trWzQ1Tg7+W8o6OXbS
         x7LQD9TENGy93kmO1yM2F1vhWYV58QvyHzSYN/jQFPLgyhe5KtAHZAdGf5AOd9jlGnc3
         Kz+yCDE2qgBb/88ly7VeQmfGAlomwyQtYGMbyt5y0CGgXMq3A2MR0wrTA2NrSn4ZX4hc
         Y2+A==
X-Gm-Message-State: APjAAAW8OZoVzA0mL3ge21WI3R4flNts/lrmop9QEcDau55aw4OPXpOJ
        9f44LkSFyOKZoqgh9ddVnVt9lc4me7k=
X-Google-Smtp-Source: APXvYqwkAgLczpi8tdZK/LeU5anvflI3b3b1dummkV5A9JA/iRkPqLw0ZXE1OkxOPucc8pFO6bN71w==
X-Received: by 2002:a6b:7112:: with SMTP id q18mr13022991iog.9.1557346108661;
        Wed, 08 May 2019 13:08:28 -0700 (PDT)
Received: from ubu (2600-6c48-437f-c81d-f514-433e-0658-d461.dhcp6.chtrptr.net. [2600:6c48:437f:c81d:f514:433e:658:d461])
        by smtp.gmail.com with ESMTPSA id u26sm6946iob.78.2019.05.08.13.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 13:08:27 -0700 (PDT)
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, gregkh@linuxfoundation.org
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: replace ktype default_attrs with default_groups
Date:   Wed,  8 May 2019 16:07:48 -0400
Message-Id: <20190508200748.3907-1-kimbrownkd@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The kobj_type default_attrs field is being replaced by the
default_groups field. Replace the default_attrs field in ext4_sb_ktype
and ext4_feat_ktype with default_groups. Use the ATTRIBUTE_GROUPS macro
to create ext4_groups and ext4_feat_groups.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---

This patch depends on a patch in the driver-core tree:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-next&id=aa30f47cf666111f6bbfd15f290a27e8a7b9d854

Greg KH can take this patch through the driver-core tree, or this patch
can wait a release cycle and go through the subsystem's tree, whichever
the subsystem maintainer is more comfortable with.


 fs/ext4/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 616c075da062..ef3b82dba59b 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -230,6 +230,7 @@ static struct attribute *ext4_attrs[] = {
 	ATTR_LIST(journal_task),
 	NULL,
 };
+ATTRIBUTE_GROUPS(ext4);
 
 /* Features this copy of ext4 supports */
 EXT4_ATTR_FEATURE(lazy_itable_init);
@@ -250,6 +251,7 @@ static struct attribute *ext4_feat_attrs[] = {
 	ATTR_LIST(metadata_csum_seed),
 	NULL,
 };
+ATTRIBUTE_GROUPS(ext4_feat);
 
 static void *calc_ptr(struct ext4_attr *a, struct ext4_sb_info *sbi)
 {
@@ -368,13 +370,13 @@ static const struct sysfs_ops ext4_attr_ops = {
 };
 
 static struct kobj_type ext4_sb_ktype = {
-	.default_attrs	= ext4_attrs,
+	.default_groups = ext4_groups,
 	.sysfs_ops	= &ext4_attr_ops,
 	.release	= ext4_sb_release,
 };
 
 static struct kobj_type ext4_feat_ktype = {
-	.default_attrs	= ext4_feat_attrs,
+	.default_groups = ext4_feat_groups,
 	.sysfs_ops	= &ext4_attr_ops,
 	.release	= (void (*)(struct kobject *))kfree,
 };
-- 
2.17.1

