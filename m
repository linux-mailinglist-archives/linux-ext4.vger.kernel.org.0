Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC907D14DA
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Oct 2023 19:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjJTR04 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Oct 2023 13:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjJTR0y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Oct 2023 13:26:54 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD7ED78
        for <linux-ext4@vger.kernel.org>; Fri, 20 Oct 2023 10:26:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9be02fcf268so163340066b.3
        for <linux-ext4@vger.kernel.org>; Fri, 20 Oct 2023 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697822804; x=1698427604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hFd/PeJUrCqAUlQIC7OhOkLtSLgI8B2z7y+zqnxlUNQ=;
        b=OfGJEPhnc0FM12mb0/PglYwg3d9ioh1VclQkm/RleoLtT9F7NDk1yS8UsDlbcls34H
         HquzbTBcQXFBrr7OHmr8W3r0E2898iBQuZWMB+7t/pH4KOHFrpcXRFmbm5j2q3Kcdhsg
         tL1kEIFdmmUpH2YbFU4HdpB0tTJ1TWqGFga/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697822804; x=1698427604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFd/PeJUrCqAUlQIC7OhOkLtSLgI8B2z7y+zqnxlUNQ=;
        b=vGzj6TspGfJpLMSE1fR1Bf7hMUMtKcyrunAkv4UMSZjMdl5n9OlpjL9dvCAspulfzQ
         JjLFwcZZ4SEHhS1LRy5zCfwfKP+98C24LXgkRY/q3Z7FNL/LprMv6QVH3tTR4xd7YGWM
         sCfZ0c2aSPd2w1nS2bcjdepnR4vWHHO7jwQcPZSgq9UbDEmJXJgz3DaTFKEp3Bwy48TK
         okz8amxCS0JgjhNMNvGptPk/fsjHbYl9S/74BHB7shak9FqVxOalR1xXnAouvRn+hrUO
         tq76W0KEMjtOSF5fIeaytSPMAAJ1u6yXLjInLkBQeYX8oXqOvbInj1UspDaP3f8F6uPh
         jJkw==
X-Gm-Message-State: AOJu0YzR1kYRD2H/N8uMzfSEUqe/rCHneVohDkUJd+W9EldjhYKQOLpw
        5OkFsNxhw+mzehj8GdkWZuIVE+xjTTi4E33rhddxI0bN
X-Google-Smtp-Source: AGHT+IGA5Ok6Cvy99OWqDkYzOjnEJ6ltAjMjn7GSE6wXpiB0odFp7wqrGgmL9qwDH+++AJYRunVmeg==
X-Received: by 2002:a17:906:73ca:b0:9ae:7081:402e with SMTP id n10-20020a17090673ca00b009ae7081402emr1402092ejl.64.1697822804454;
        Fri, 20 Oct 2023 10:26:44 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id k15-20020a1709065fcf00b00997d7aa59fasm1928130ejv.14.2023.10.20.10.26.43
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 10:26:44 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso1612264a12.3
        for <linux-ext4@vger.kernel.org>; Fri, 20 Oct 2023 10:26:43 -0700 (PDT)
X-Received: by 2002:a17:906:fe06:b0:9bf:1477:ad82 with SMTP id
 wy6-20020a170906fe0600b009bf1477ad82mr2068018ejb.76.1697822803062; Fri, 20
 Oct 2023 10:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <ZTFAzuE58mkFbScV@smile.fi.intel.com> <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com> <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com> <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com> <ZTKXbbSS2Pvmc-Fh@smile.fi.intel.com> <ZTKY6nRGWoYsEJjj@smile.fi.intel.com>
In-Reply-To: <ZTKY6nRGWoYsEJjj@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Oct 2023 10:26:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzn2AVM6iSfy64h8TPjL6DtirO-YKW9o8afEw1s9nbjw@mail.gmail.com>
Message-ID: <CAHk-=whzn2AVM6iSfy64h8TPjL6DtirO-YKW9o8afEw1s9nbjw@mail.gmail.com>
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Baokun Li <libaokun1@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ferry Toth <ftoth@exalondelft.nl>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 20 Oct 2023 at 08:12, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> > > --- a/fs/quota/dquot.c
> > > +++ b/fs/quota/dquot.c
> > > @@ -632,8 +632,10 @@ static inline int dquot_write_dquot(struct dquot *dquot)
> > >  {
> > >         int ret = dquot->dq_sb->dq_op->write_dquot(dquot);
> > >         if (ret < 0) {
> > > +#if 0
> > >                 quota_error(dquot->dq_sb, "Can't write quota structure "
> > >                             "(error %d). Quota may get out of sync!", ret);
> > > +#endif
> > >                 /* Clear dirty bit anyway to avoid infinite loop. */
> > >                 clear_dquot_dirty(dquot);
> > >         }
>
> Doing the same on the my branch based on top of v6.6-rc6 does not help.
> So looks like a race condition somewhere happening related to that dirty bit
> (as comment states it needs to be cleaned to avoid infinite loop, that's
>  probably what happens).

Hmm. Normally, dirty bits should always be cleared *before* the
write-back, not after it. Otherwise you might lose a dirty event that
happened *during* writeback.

But I don't know the quota code.

... the fact that the #if 0 doesn't help in another case does say that
it's not the quota_error() call itself. Which it really couldn't have
been (apart from timing and compiler bugs), but it's still a data
point, I guess.

               Linus
