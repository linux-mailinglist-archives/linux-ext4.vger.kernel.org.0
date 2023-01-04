Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE9B65D08E
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 11:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjADKYR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 05:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjADKYQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 05:24:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C012D193FB
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 02:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672827812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ObnUHKxvEczvfH3lRNZHwf5XmrUPu47QR7kYMSwnUnk=;
        b=MqE1SrKI2DgyST9pcwGN2GSmai7tBl5/JsbqSnMKn5jnZh2RY/NzFMZ/rLeYu1iCzMEcUQ
        09W74ZWWEZAbvBB7V1UYIPm1/uo+SmVoP/Gs4trqaR7TlI+3s+Q2SiH1rQjCpjIW9ZMWrO
        JrliZu4Yir/ZCq7YDdO6CkkAM+NFy9w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-H4DRYmPIPwaURSUz6OYCmg-1; Wed, 04 Jan 2023 05:23:29 -0500
X-MC-Unique: H4DRYmPIPwaURSUz6OYCmg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17C5585C069;
        Wed,  4 Jan 2023 10:23:29 +0000 (UTC)
Received: from fedora (ovpn-192-227.brq.redhat.com [10.40.192.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 55A1B140EBF5;
        Wed,  4 Jan 2023 10:23:28 +0000 (UTC)
Date:   Wed, 4 Jan 2023 11:23:26 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: Re: [e2fsprogs PATCH] libext2fs: remove unused variable in
 ext2fs_xattrs_read_inode()
Message-ID: <20230104102326.eoitvoj3bbcp6oqd@fedora>
References: <20230104090314.276028-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230104090314.276028-1-ebiggers@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 04, 2023 at 01:03:14AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Address the following compiler warning with gcc -Wall:
> 
> ext_attr.c: In function ‘ext2fs_xattrs_read_inode’:
> ext_attr.c:1000:16: warning: unused variable ‘i’ [-Wunused-variable]
>  1000 |         size_t i;
>       |                ^

You might as well remove the unnecessary newline at the top of the
function.

But regardless, you can add.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Thanks!
-Lukas

> 
> Cc: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  lib/ext2fs/ext_attr.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/lib/ext2fs/ext_attr.c b/lib/ext2fs/ext_attr.c
> index d36fe68d..6fc4214c 100644
> --- a/lib/ext2fs/ext_attr.c
> +++ b/lib/ext2fs/ext_attr.c
> @@ -997,7 +997,6 @@ errcode_t ext2fs_xattrs_read_inode(struct ext2_xattr_handle *handle,
>  	unsigned int storage_size;
>  	char *start, *block_buf = NULL;
>  	blk64_t blk;
> -	size_t i;
>  	errcode_t err = 0;
>  
>  	EXT2_CHECK_MAGIC(handle, EXT2_ET_MAGIC_EA_HANDLE);
> -- 
> 2.39.0
> 

