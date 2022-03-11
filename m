Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304104D5974
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Mar 2022 05:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242937AbiCKEST (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Mar 2022 23:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346195AbiCKESP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Mar 2022 23:18:15 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867211A274A
        for <linux-ext4@vger.kernel.org>; Thu, 10 Mar 2022 20:17:13 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b15so5368324edn.4
        for <linux-ext4@vger.kernel.org>; Thu, 10 Mar 2022 20:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wzT8zoxzQUK2WEeSQssoFnxlwncxeJI+pT8W14ygBQ=;
        b=WvHlh/FM5NvwvVqiHSkm5EZzfTE13jGMzBQwHAvrDbuoSr5HdU6X9XBdckNDWivOQC
         6Qy6E4yLQyg1KH9yuNtPA0RI3AwpuDXwPn8UXVEWiIcVTODUGXW9P60nR3RvtUQM6JjD
         oN9bg6SLFKO3JWQJjFdYKdRnXBv4gADCKjXrwx0u9JJtkIcworaKcpozc6M4rwGOV5y9
         PnJfMS7IMBUs6y6ahG3j9B7s46MshHHJro49ID0e3ZBnhf2WxRY7b11P8QgRTUWLroL2
         Vg5YE20CKFV87iiHwGFcUb+ENlTe4Fwi4mmnHOVVAzEv5x6hH73C/hRGBe/9QjR3x4FL
         u/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wzT8zoxzQUK2WEeSQssoFnxlwncxeJI+pT8W14ygBQ=;
        b=4vo/nWUtEuxSC6yE+P1qmyXAljdS73wdVyxQIdaBiUYqgegAsNiI+ZN0UxZYgZaRVR
         CugrqrQ8Sk4PsP5xfj+zs5ccr85r/RJi+aasKrURhkwg+Ox7BWgpRSwDtzyK10Q/cuQS
         siNuIrNWfDJ2Zk7tBgfX3cezbjx4sO9P/LM7dl+QUzbBpwEOcdOHD+OhpmwtJmGHbPCF
         owpjwcWTdodFe9jvmTDDE9UHpoNjGNHDnxFU5yD4c7EwFEOGP8ZEeiJGhOsipSPDacqs
         U6Xi8PksNY7jIRtk0X2Tj4gZBXFb81iUTJlEyQxX+idQQpiOOMZzraD4NZzA/tNENVkR
         kk6A==
X-Gm-Message-State: AOAM532ofZvzGsrC6RbspRbNS5MObEGJkyCNsd1H0FD+WSP7JnXjIvGr
        E6THDoLR/dqU1RN37eaQ6ZW0jj/71LQmdA3jXak=
X-Google-Smtp-Source: ABdhPJypTLtRG6HRLS0WbyybiLtQfC6v81HfTjySKd9KFnSrru0xb55xpCUdoSj84tktBZMVkOnKTppKmwzfM5Lw8N0=
X-Received: by 2002:a05:6402:1c1e:b0:416:5b93:eacf with SMTP id
 ck30-20020a0564021c1e00b004165b93eacfmr7153195edb.302.1646972231932; Thu, 10
 Mar 2022 20:17:11 -0800 (PST)
MIME-Version: 1.0
References: <20220308163319.1183625-1-harshads@google.com> <20220308163319.1183625-3-harshads@google.com>
 <20220309101426.qumxztpd4weqzrcs@quack3.lan>
In-Reply-To: <20220309101426.qumxztpd4weqzrcs@quack3.lan>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 10 Mar 2022 20:17:00 -0800
Message-ID: <CAD+ocbyM9HdZwpB_NzKAiJTsZ78gZ_4Hsk3c21tL4ZetapqcFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] ext4: for committing inode, make
 ext4_fc_track_inode wait
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the reviews Jan! I'll update inline.c as you mentioned in
the next version.

- Harshad

On Wed, 9 Mar 2022 at 02:14, Jan Kara <jack@suse.cz> wrote:
>
> On Tue 08-03-22 08:33:16, Harshad Shirwadkar wrote:
> > From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> >
> > If the inode that's being requested to track using ext4_fc_track_inode
> > is being committed, then wait until the inode finishes the commit.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> One comment below...
>
> > --- a/fs/ext4/ext4_jbd2.c
> > +++ b/fs/ext4/ext4_jbd2.c
> > @@ -106,6 +106,18 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
> >                                  GFP_NOFS, type, line);
> >  }
> >
> > +handle_t *__ext4_journal_start(struct inode *inode, unsigned int line,
> > +                               int type, int blocks, int rsv_blocks,
> > +                               int revoke_creds)
> > +{
> > +     handle_t *handle = __ext4_journal_start_sb(inode->i_sb, line,
> > +                                                type, blocks, rsv_blocks,
> > +                                                revoke_creds);
> > +     if (ext4_handle_valid(handle) && !IS_ERR(handle))
> > +             ext4_fc_track_inode(handle, inode);
> > +     return handle;
> > +}
> > +
>
> Please fix fs/ext4/inline.c rather than papering over the problem like
> this. Because it is just a landmine waiting to explode in some strange
> cornercase when someone does not call ext4_journal_start() but other handle
> starting function.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
