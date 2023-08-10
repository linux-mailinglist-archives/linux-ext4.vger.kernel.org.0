Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C687A7775DB
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Aug 2023 12:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjHJKbj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 06:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHJKbW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 06:31:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669FB9F
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 03:31:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31763b2c5a4so719182f8f.3
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691663480; x=1692268280;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lU7Ri9xPkLKk42X5+szAqAo5yarzjOhf2O1nvihU7/M=;
        b=B9ikYWspvFX/AyNjsTLnSUyHZnrAjWEMxu6xxy0Yl3bsrUnzgY4ywG5/imqNZtp0vW
         RsTgOGSGP8DZi0TU1NgQZ6bdRHx7k1Fc2D0eIX8KWuvQcVxphKsFTF77SZMBzJztWTyT
         6R99a9kuXLPTxcVAdFTSIQwCRIaHtZmjhUHnScCPZOoxbypiwYKFEAUE1/b0PhcrKtsn
         vvyIqoA2lfpY21mvm4yK7E4jRf0BMcJNbLAXCxyq+PMsKgacb1T+WnNqU2uDAjLYF2Zl
         WdZFx6k5l48HZClZ3D2KRlOqG8G5AMyFciN4eWtqqwXlJDQ9m/K6Q+aZpqWolwZP1Sv/
         cI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663480; x=1692268280;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lU7Ri9xPkLKk42X5+szAqAo5yarzjOhf2O1nvihU7/M=;
        b=AQ5weRIMJUwjAO0KFaxe8VY1oPZ2GWt6lmLRG3MeHvoTKxoTehP3VGujBYvVVOlpve
         GhykwN/nNUi+htO8+vGerWCrmx3VRghpQYRJSzTX3YSZg7lwL7sKETOJzHbAWhYF7bPz
         uBVSfBMou3qk5hGeukn2ppt4kAFXVZwjEoNMimx6fzGWDYz7Lf2s8+vTKqJ+uMTQtyZO
         KMYv8Tf32OF6Krebc3t1Rm4mCiod5H5dSpjzbahUxqoMBKDKqxaONm+0q52IjOAMpxSl
         s06AlSwNy3O+YIj8M5uFPMCyh38/om0tqBT9DpVbTCAlATxFhp6rNL9JMIbZLk1ZhB6G
         C75g==
X-Gm-Message-State: AOJu0YwKAEyYmj4ViiDiensXEDg5CrOJWbozgcDXcbHBP2Tg79LfAPSg
        iB3kZQUkh/VrxyYa1ULGa955H8EnokW6TnWj6kA=
X-Google-Smtp-Source: AGHT+IG3Mniya89OHm7iQCX1788Ot7gN1kVdb9BU0dc5emlfC3LA5wdqoZOvVgmq2Okng8WBBlWHuA==
X-Received: by 2002:a5d:4531:0:b0:317:5ddd:837b with SMTP id j17-20020a5d4531000000b003175ddd837bmr1828263wra.7.1691663479909;
        Thu, 10 Aug 2023 03:31:19 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t16-20020a05600001d000b00317b5c8a4f1sm1715921wrx.60.2023.08.10.03.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:31:19 -0700 (PDT)
Date:   Thu, 10 Aug 2023 13:31:16 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     yi.zhang@huawei.com
Cc:     linux-ext4@vger.kernel.org
Subject: [bug report] ext4: convert symlink external data block mapping to
 bdev
Message-ID: <797feb23-f8c8-4ce7-b25c-b4f591be1387@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Zhang Yi,

The patch 6493792d3299: "ext4: convert symlink external data block
mapping to bdev" from Apr 24, 2022 (linux-next), leads to the
following Smatch static checker warning:

	fs/ext4/namei.c:3353 ext4_init_symlink_block()
	error: potential NULL/IS_ERR bug 'bh'

fs/ext4/namei.c
    3337 static int ext4_init_symlink_block(handle_t *handle, struct inode *inode,
    3338                                    struct fscrypt_str *disk_link)
    3339 {
    3340         struct buffer_head *bh;
    3341         char *kaddr;
    3342         int err = 0;
    3343 
    3344         bh = ext4_bread(handle, inode, 0, EXT4_GET_BLOCKS_CREATE);
    3345         if (IS_ERR(bh))
    3346                 return PTR_ERR(bh);

From reading the code, it looks like ext4_bread() can return both error
pointers and NULL.  (Second return statement).

    3347 
    3348         BUFFER_TRACE(bh, "get_write_access");
    3349         err = ext4_journal_get_write_access(handle, inode->i_sb, bh, EXT4_JTR_NONE);
    3350         if (err)
    3351                 goto out;
    3352 
--> 3353         kaddr = (char *)bh->b_data;
                                 ^^^^
Unchecked dereference

    3354         memcpy(kaddr, disk_link->name, disk_link->len);
    3355         inode->i_size = disk_link->len - 1;
    3356         EXT4_I(inode)->i_disksize = inode->i_size;
    3357         err = ext4_handle_dirty_metadata(handle, inode, bh);
    3358 out:
    3359         brelse(bh);
    3360         return err;
    3361 }

regards,
dan carpenter
