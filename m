Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D2154000F
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jun 2022 15:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiFGNb3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jun 2022 09:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243578AbiFGNb2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jun 2022 09:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA2EFD4A19
        for <linux-ext4@vger.kernel.org>; Tue,  7 Jun 2022 06:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654608687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SvywioRWPxgSEjayzcnVuCpg6ykTfA7n27UFDFIvB5I=;
        b=J6Yf9xNud8ejoqp5c8+WFji0KGUOv7FC0M87MZ3+gtjq49jlXf6H6CpPLpbVtZduT5zxfU
        hCc/FNfrxvdOuqty9PKK9vjZqMJvLvPekGaJ9F9EPJYt1Ja4lWZy4DH8d+Q54wZLdVsy2S
        ymOp2r81t//2RjinbQigqnUsRugoyyQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-I5cdqb43N_qj2IDU6o0KMw-1; Tue, 07 Jun 2022 09:31:25 -0400
X-MC-Unique: I5cdqb43N_qj2IDU6o0KMw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E19731C3E992;
        Tue,  7 Jun 2022 13:31:24 +0000 (UTC)
Received: from fedora (unknown [10.40.193.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EAA0D8288C;
        Tue,  7 Jun 2022 13:31:23 +0000 (UTC)
Date:   Tue, 7 Jun 2022 15:31:21 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Nils Bars <nils.bars@rub.de>,
        Moritz =?utf-8?B?U2NobMO2Z2Vs?= <moritz.schloegel@rub.de>,
        Nico Schiller <nico.schiller@rub.de>
Subject: Re: [PATCH 3/7] libext2fs: add check for too-short directory blocks
Message-ID: <20220607133121.vfs7rynipdanyqkt@fedora>
References: <20220607042444.1798015-1-tytso@mit.edu>
 <20220607042444.1798015-4-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607042444.1798015-4-tytso@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 07, 2022 at 12:24:40AM -0400, Theodore Ts'o wrote:
> If there is an inline data directory which is smaller than 8 bytes
> (which should never happen but for corrupted or fuzzed file systems),
> ext2fs_process_dir_block() will now abort EXT2_ET_DIR_CORRUPTED to
> avoid an out-of-bounds read.

Looks good.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Reported-by: Nils Bars <nils.bars@rub.de>
> Reported-by: Moritz Schlögel <moritz.schloegel@rub.de>
> Reported-by: Nico Schiller <nico.schiller@rub.de>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  lib/ext2fs/dir_iterate.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/ext2fs/dir_iterate.c b/lib/ext2fs/dir_iterate.c
> index b2b77693..7798a482 100644
> --- a/lib/ext2fs/dir_iterate.c
> +++ b/lib/ext2fs/dir_iterate.c
> @@ -221,6 +221,10 @@ int ext2fs_process_dir_block(ext2_filsys fs,
>  	if (ext2fs_has_feature_metadata_csum(fs->super))
>  		csum_size = sizeof(struct ext2_dir_entry_tail);
>  
> +	if (buflen < 8) {
> +		ctx->errcode = EXT2_ET_DIR_CORRUPTED;
> +		return BLOCK_ABORT;
> +	}
>  	while (offset < buflen - 8) {
>  		dirent = (struct ext2_dir_entry *) (ctx->buf + offset);
>  		if (ext2fs_get_rec_len(fs, dirent, &rec_len))
> -- 
> 2.31.0
> 

