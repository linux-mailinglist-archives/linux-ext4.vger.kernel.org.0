Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F8E392978
	for <lists+linux-ext4@lfdr.de>; Thu, 27 May 2021 10:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhE0IYz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 May 2021 04:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbhE0IYz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 May 2021 04:24:55 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA1EC061760
        for <linux-ext4@vger.kernel.org>; Thu, 27 May 2021 01:23:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso2039465wmm.3
        for <linux-ext4@vger.kernel.org>; Thu, 27 May 2021 01:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=43EyW5t8QfuvIRH8wC3AegWTcYZjbOc3TBDwp+clb3A=;
        b=dnvTIhAq8y74Gvyi5lJrY+u21ePXWeZMnvlCeRqCfcUBVFag6aopPIZK8vyVl+bJw8
         cmSV0vlEGj5E5HPLqkDjS4zHBkqjEfx8neBmiOiXtQStTEWpTctAqqqVr8mDUECZqXRD
         I29WhIzfssITgSquYB0x1+wOuMwOXMLFH0w2W684faGNaQFxea5dblJzj6iEkCVGdRcu
         kWy5WHS6uHySy1wNy4gZZDqWymWaF1jqOmITHs3A2YTxVEKKOF0wxyebwoRkVSXxaNx7
         zdt+lwCRVCmA1p15wsKjWWUJtwURf2SL12jadmHKVMFU7vTYrmTfzPctdpJXPGnk1YGd
         R/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=43EyW5t8QfuvIRH8wC3AegWTcYZjbOc3TBDwp+clb3A=;
        b=F3hO2vztYwIeS2sMLJPJTKzrUZoLFVIgIX1vwmdwpBqPgtW8GteTIotdm+eQA/kMXI
         KLo5JGuKk1fJ2Z13PdiQxPPzG+PtWabPgCXw7ir1OYBfHIDbCgLtqL1EtZHmqybmKagT
         Q+8e/UBFPyMzg6iEBHUERnJ0WJ3efTQiPYN/4eyhgGju5tOwOI+nXi9wCbXr8aJ15vTy
         EPDehn+XrCrDnYuzAOrXt58LE6PINjpck1bn+ZZYu+cvt1TbhldwgxTp7PnLCtto0PQz
         BLf3lQKXIE0jeNF2jWPJI3npNAhEgk92ZDQn4a4CcWo1e6YCcv0xU7WSXcqqcDkwvwnH
         uqEw==
X-Gm-Message-State: AOAM530PgIscxtoW9lIa0uO7k7oImd+8+tXJJrcivFUT9JFWormOi4dZ
        N+0j5j4TmOkSDS23FBjR4RXB2w==
X-Google-Smtp-Source: ABdhPJxkFXWDgl3F5EEVw0suVP3rVhu42453i5OaMcsvSQ30QC/xJpgr+ClUpXnlQxvb3lbZP32amw==
X-Received: by 2002:a1c:a5c3:: with SMTP id o186mr2254998wme.6.1622103799913;
        Thu, 27 May 2021 01:23:19 -0700 (PDT)
Received: from dell ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id a11sm2031588wrr.48.2021.05.27.01.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 01:23:19 -0700 (PDT)
Date:   Thu, 27 May 2021 09:23:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     riteshh <riteshh@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Remy Card <card@masi.ibp.fr>,
        "David S. Miller" <davem@caip.rutgers.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/1] fs: ext4: namei: trivial: Fix a couple of small
 whitespace issues
Message-ID: <20210527082317.GI543307@dell>
References: <20210520125558.3476318-1-lee.jones@linaro.org>
 <20210527031134.zqewpd2tqo7umoho@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210527031134.zqewpd2tqo7umoho@riteshh-domain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 27 May 2021, riteshh wrote:

> On 21/05/20 01:55PM, Lee Jones wrote:
> 
> Hi Lee,
> 
> Thanks for your patch. I see we could a little better here.
> There are several other checkpatch ERROR msgs in this file.
> Care to fix all of those ERRORS within the same patch itself?

I don't think it's a good idea to mix functionality within a single
patch.  However, I would be happy to provide a follow-up solving these
issues for you.

> ./scripts/checkpatch.pl -f fs/ext4/namei.c | sed -n '/ERROR/,/^$/p'
> 
> e.g. to list a few of them -
> ERROR: do not use assignment in if condition
> #1605: FILE: fs/ext4/namei.c:1605:
> +               if ((bh = bh_use[ra_ptr++]) == NULL)
> 
> ERROR: space required after that ',' (ctx:VxV)
> #1902: FILE: fs/ext4/namei.c:1902:
> +                       struct buffer_head **bh,struct dx_frame *frame,
>                                                ^
> 
> ERROR: space required after that ',' (ctx:VxV)
> #2249: FILE: fs/ext4/namei.c:2249:
> +       de = do_split(handle,dir, &bh2, frame, &fname->hinfo);
>                             ^
> 
> ERROR: spaces required around that '=' (ctx:VxV)
> #2288: FILE: fs/ext4/namei.c:2288:
> +       int     dx_fallback=0;
> 
> -ritesh
> 
> > Cc: "Theodore Ts'o" <tytso@mit.edu>
> > Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> > Cc: Remy Card <card@masi.ibp.fr>
> > Cc: "David S. Miller" <davem@caip.rutgers.edu>
> > Cc: linux-ext4@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  fs/ext4/namei.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > index afb9d05a99bae..7e780cf311c5a 100644
> > --- a/fs/ext4/namei.c
> > +++ b/fs/ext4/namei.c
> > @@ -1899,7 +1899,7 @@ static struct ext4_dir_entry_2 *dx_pack_dirents(struct inode *dir, char *base,
> >   * Returns pointer to de in block into which the new entry will be inserted.
> >   */
> >  static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
> > -			struct buffer_head **bh,struct dx_frame *frame,
> > +			struct buffer_head **bh, struct dx_frame *frame,
> >  			struct dx_hash_info *hinfo)
> >  {
> >  	unsigned blocksize = dir->i_sb->s_blocksize;
> > @@ -2246,7 +2246,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
> >  	if (retval)
> >  		goto out_frames;
> >
> > -	de = do_split(handle,dir, &bh2, frame, &fname->hinfo);
> > +	de = do_split(handle, dir, &bh2, frame, &fname->hinfo);
> >  	if (IS_ERR(de)) {
> >  		retval = PTR_ERR(de);
> >  		goto out_frames;
> >

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
