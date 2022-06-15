Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC31454C8D9
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jun 2022 14:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbiFOMrC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jun 2022 08:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiFOMq7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Jun 2022 08:46:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488B146C8C;
        Wed, 15 Jun 2022 05:46:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0603D1F913;
        Wed, 15 Jun 2022 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655297216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kCc+fqfVJ1178TStTubhr5OsC5cJgYZfRKAp/t26xnE=;
        b=tf+peZdELak5lxAWLvBE/N4XgbTrf1OHqfbVynRzidCnDm7YCzgsOqy5R1hqqLi6MgEzW+
        m9aCUtSljjZszAUcNZTX5wDMOYljQlNoklg3LI2MYLhmpMtCZ1BSCPEt0iBCoacCy+6C7B
        qMkgp2w0HVuDxJnSAcIiQSyGXQWKcrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655297216;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kCc+fqfVJ1178TStTubhr5OsC5cJgYZfRKAp/t26xnE=;
        b=0Y23oh85gCCILdW5DFoJ2AyTjGokSxU3hCB5zxczcBZvu/YA5YXYysripfCi1hQjrKBW5V
        7E8IQ/eIJnstoGAw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DA5932C141;
        Wed, 15 Jun 2022 12:46:45 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AC595A062E; Wed, 15 Jun 2022 14:46:33 +0200 (CEST)
Date:   Wed, 15 Jun 2022 14:46:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        lczerner@redhat.com, enwlinux@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 1/4] ext4: add EXT4_INODE_HAVE_XATTR_SPACE macro in
 xattr.h
Message-ID: <20220615124633.6uddzv5msnmwi7c4@quack3.lan>
References: <20220615040630.808783-1-libaokun1@huawei.com>
 <20220615040630.808783-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615040630.808783-2-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 15-06-22 12:06:27, Baokun Li wrote:
> When adding an xattr to an inode, we must ensure that the inode_size is
> not less than EXT4_GOOD_OLD_INODE_SIZE + extra_isize + pad. Otherwise,
> the end position may be greater than the start position, resulting in UAF.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

...

> +/*
> + * If we want to add an xattr to the inode, we should make sure that
> + * i_extra_isize is not 0 and that the inode size is not less than
> + * EXT4_GOOD_OLD_INODE_SIZE + extra_isize + pad.
> + *   EXT4_GOOD_OLD_INODE_SIZE   extra_isize header   entry   pad  data
> + * |--------------------------|------------|------|---------|---|-------|
> + */
> +#define EXT4_INODE_HAVE_XATTR_SPACE(inode)				\

Gramatically correct would be EXT4_INODE_**HAS**_XATTR_SPACE and I'd be for
using that. Otherwise the whole series looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
