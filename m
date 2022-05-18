Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D642E52C340
	for <lists+linux-ext4@lfdr.de>; Wed, 18 May 2022 21:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241832AbiERTUv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 15:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241829AbiERTUv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 15:20:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B39BF57
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 12:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 395A561888
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 19:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560F9C385A9;
        Wed, 18 May 2022 19:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652901647;
        bh=rP1V47fuAQdnud9qXZhFmg0TYruAtH05GnMFhrZhVME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bTg/C7ThWkW2TTbMTsjcxexM1PbHwENIe9sOBoHxoLD5moZTXEAw22ifb5U1Be1Tt
         kw6n0veOaOyNI5BF04AzrO77F/0pyhrAmzeIxpMWm+y21a3l3CIpEsBVhMFJ1w5fwQ
         qOhNHlF+oPW0H9FVTjFMeEM+j8h5sqIjHHgBSkabLpTAYdOPgYYap8yGfTpdWdPxEK
         S29jeBzzBEtf3nE0i6/DaNeYYsCRRvY4Un5IvLo+UhS88snF83jMqm6lnLiSjXgRdg
         mMXFv+5LmPjqUJylqz/WGiv7skuwqWzzUCJ/JYcNZNt+iA4GjCg9jDlQblMFAS42RE
         FA68xjQ4BODFQ==
Date:   Wed, 18 May 2022 12:20:45 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v5 4/8] ext4: Reuse generic_ci_match for ci comparisons
Message-ID: <YoVHDdMYx5Lbn7aP@sol.localdomain>
References: <20220518172320.333617-1-krisman@collabora.com>
 <20220518172320.333617-5-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518172320.333617-5-krisman@collabora.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 18, 2022 at 01:23:16PM -0400, Gabriel Krisman Bertazi wrote:
> Instead of reimplementing ext4_match_ci, use the new libfs helper.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
[...]
>  int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
>  				  struct ext4_filename *name)
>  {
> @@ -1432,20 +1380,25 @@ static bool ext4_match(struct inode *parent,
>  #if IS_ENABLED(CONFIG_UNICODE)
>  	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent) &&
>  	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
> -		if (fname->cf_name.name) {
> -			if (IS_ENCRYPTED(parent)) {
> -				if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
> -					fname->hinfo.minor_hash !=
> -						EXT4_DIRENT_MINOR_HASH(de)) {
> +		int ret;
>  
> -					return false;
> -				}
> -			}
> -			return !ext4_ci_compare(parent, &fname->cf_name,
> -						de->name, de->name_len, true);
> +		if (IS_ENCRYPTED(parent) &&
> +		    (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
> +		     fname->hinfo.minor_hash != EXT4_DIRENT_MINOR_HASH(de)))
> +			return false;
> +
> +		ret = generic_ci_match(parent, fname->usr_fname,
> +				       &fname->cf_name, de->name,
> +				       de->name_len);
> +		if (ret < 0) {
> +			/*
> +			 * Treat comparison errors as not a match.  The
> +			 * only case where it happens is on a disk
> +			 * corruption or ENOMEM.
> +			 */
> +			return false;
>  		}
> -		return !ext4_ci_compare(parent, fname->usr_fname, de->name,
> -						de->name_len, false);
> +		return ret;
>  	}

This needs an explanation for why it's okay to remove
'fname->cf_name.name != NULL' from the condition for doing the hash comparison
for an encrypted+casefolded directory entry.

- Eric
