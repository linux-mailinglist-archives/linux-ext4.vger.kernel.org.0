Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2A752C2FF
	for <lists+linux-ext4@lfdr.de>; Wed, 18 May 2022 21:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241749AbiERTFf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 15:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241746AbiERTFe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 15:05:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849023DA5E
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 12:05:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20879618B8
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 19:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F799C34113;
        Wed, 18 May 2022 19:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652900732;
        bh=cnpn7fseaG033r+jdaVt9hFU29BawCKPe9gTGSUle1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pAF7TFbOKVH4z+mtmH2nuKWJn5qnaGln3FEjUkontCQjqqyZ2FUi7/6Jsvos2HEjy
         zJEPUlLJo8gNVicfbM7r4LldaFJo6bM+8chsnnvFZsgiSDnwZ/QLitwP3wQyGrJLI0
         9Kt32iyBilTi5ioX26ZbXh3Am3v0w0tKjdKsBQfhJHPtQdiKNu9RqTDkWZBfA4us6v
         aIfcEz0SXSl9GWlUgZAQNHxTRTdIABOTmzJIhQSccuJUzPhzQiFWUzFsKV4bbhhxAs
         VOY1ePjVzDGQTlV5kaSV+5F2B4noMqHj6Sp8JS8/QgAoBv0yJFw99SYPuzWBLJOXKC
         a4DoxeIUpNdsQ==
Date:   Wed, 18 May 2022 12:05:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v5 3/8] libfs: Introduce case-insensitive string
 comparison helper
Message-ID: <YoVDejdYnHtIMxs6@sol.localdomain>
References: <20220518172320.333617-1-krisman@collabora.com>
 <20220518172320.333617-4-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518172320.333617-4-krisman@collabora.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 18, 2022 at 01:23:15PM -0400, Gabriel Krisman Bertazi wrote:
> generic_ci_match can be used by case-insensitive filesystems to compare
> strings under lookup with dirents in a case-insensitive way.  This
> function is currently reimplemented by each filesystem supporting
> casefolding, so this reduces code duplication in filesystem-specific
> code.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/libfs.c         | 65 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  4 +++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 974125270a42..6861d43563be 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1465,6 +1465,71 @@ static const struct dentry_operations generic_ci_dentry_ops = {
>  	.d_hash = generic_ci_d_hash,
>  	.d_compare = generic_ci_d_compare,
>  };
> +
> +/**
> + * generic_ci_match() - Match a name (case-insensitively) name with a dirent.
> + * @parent: Inode of the parent of the dirent under comparison
> + * @name: name under lookup.
> + * @folded_name: Optional pre-folded name under lookup
> + * @de_name: Dirent name.
> + * @de_name_len: dirent name length.
> + *
> + *
> + * Test whether a case-insensitive directory entry matches the filename
> + * being searched.  If @folded_name is provided, it is used instead of
> + * recalculating the casefold of @name.
> + *
> + * Return: > 0 if the directory entry matches, 0 if it doesn't match, or
> + * < 0 on error.
> + */
> +int generic_ci_match(const struct inode *parent,
> +		     const struct qstr *name,
> +		     const struct qstr *folded_name,
> +		     const u8 *de_name, size_t de_name_len)
> +{
> +	const struct super_block *sb = parent->i_sb;
> +	const struct unicode_map *um = sb->s_encoding;
> +	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);

de_name_len is getting truncated to u32, so the parameter itself should be a
u32, like f2fs_match_ci_name().

> +	struct qstr dirent = QSTR_INIT(de_name, de_name_len);
> +	int err, match = false;
> +
> +	if (IS_ENCRYPTED(parent)) {
> +		const struct fscrypt_str encrypted_name =
> +			FSTR_INIT((u8 *) de_name, de_name_len);

The 'if (WARN_ON_ONCE(!fscrypt_has_encryption_key(parent))) return -EINVAL;'
from f2fs_match_ci_name() should be kept here, as this is not going to work as
intended if the encryption key is unavailable.  (Unless the name is "." or "..",
as you saw in my recent patch, but that should be avoided anyway.)

> +
> +		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
> +		if (!decrypted_name.name)
> +			return -ENOMEM;
> +		err = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
> +						&decrypted_name);
> +		if (err < 0)
> +			goto out;
> +		dirent.name = decrypted_name.name;
> +		dirent.len = decrypted_name.len;
> +	}
> +
> +	if (folded_name->name)
> +		err = utf8_strncasecmp_folded(um, folded_name, &dirent);
> +	else
> +		err = utf8_strncasecmp(um, name, &dirent);

Variables called 'err' conventionally store either 0 or a negative error value.
Here, 'err' can store a positive value.  It would be better to call it something
else, such as 'res' which f2fs_match_ci_name() uses.

- Eric
