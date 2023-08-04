Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885FF76F8C3
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Aug 2023 06:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjHDEHX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Aug 2023 00:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjHDEHU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Aug 2023 00:07:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4245F468A;
        Thu,  3 Aug 2023 21:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D489361C0D;
        Fri,  4 Aug 2023 04:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0EDC433C7;
        Fri,  4 Aug 2023 04:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691122014;
        bh=k4zmubWOjyeMATikvgmZBrABBD9c6icxm4g9SfRcT3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nC7CqITdsS7pj6ITLpT07Xme+C8cSNojDbE00dd0P6XYxxlg18VeI2kR18SsxtczR
         C45lCqMCf2fAuKY65VOre5MqFMPZck0HCic48N0MpqhnaE1G5dj0WoVgTQj9C9EV8n
         CJPsXcOuD15BAXKKnvp331faF/STczD6TtOKFWJ4hAu9ykORJDCnCMGNQisHrgI5q0
         eMmgX5MGdHPAiDFZ14dZKW1yTN1V97h4ConISfHZ6PO9tZRA6aJlEfz2xlquIhfhK9
         mP8vlRdkszsICdJ7yPp/uRGuGIEDgfxA8KI1AvnNbgJVsg+dJwZtMWj5+XJdHaTYLD
         sl/lsqP+QLIRQ==
Date:   Thu, 3 Aug 2023 21:06:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Daniel Rosenberg <drosen@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ext4: fix memory leaks in
 ext4_fname_{setup_filename,prepare_lookup}
Message-ID: <20230804040652.GA1954@sol.localdomain>
References: <20230803091713.13239-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230803091713.13239-1-lhenriques@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 03, 2023 at 10:17:13AM +0100, Luís Henriques wrote:
> If the filename casefolding fails, we'll be leaking memory from the
> fscrypt_name struct, namely from the 'crypto_buf.name' member.
> 
> Make sure we free it in the error path on both ext4_fname_setup_filename()
> and ext4_fname_prepare_lookup() functions.
> 
> Fixes: 1ae98e295fa2 ("ext4: optimize match for casefolded encrypted dirs")
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
> Changes since v2:
> - Rephrased commit log to (hopefully!) make it more clear.
> - Use ext4_fname_free_filename() instead of fscrypt_free_filename().
>   Although not strictly needed, it cleans up the fname struct, removing a
>   dangling pointer to freed memory.
> 
> Changes since v1:
> - Include fix to ext4_fname_prepare_lookup() as well
> - Add 'Fixes:' tag
> 
>  fs/ext4/crypto.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
> index e20ac0654b3f..453d4da5de52 100644
> --- a/fs/ext4/crypto.c
> +++ b/fs/ext4/crypto.c
> @@ -33,6 +33,8 @@ int ext4_fname_setup_filename(struct inode *dir, const struct qstr *iname,
>  
>  #if IS_ENABLED(CONFIG_UNICODE)
>  	err = ext4_fname_setup_ci_filename(dir, iname, fname);
> +	if (err)
> +		ext4_fname_free_filename(fname);
>  #endif
>  	return err;
>  }
> @@ -51,6 +53,8 @@ int ext4_fname_prepare_lookup(struct inode *dir, struct dentry *dentry,
>  
>  #if IS_ENABLED(CONFIG_UNICODE)
>  	err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
> +	if (err)
> +		ext4_fname_free_filename(fname);
>  #endif
>  	return err;
>  }

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
