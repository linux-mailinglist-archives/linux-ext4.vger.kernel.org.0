Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB59731A268
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Feb 2021 17:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhBLQL6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Feb 2021 11:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhBLQL5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Feb 2021 11:11:57 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C4EC061574
        for <linux-ext4@vger.kernel.org>; Fri, 12 Feb 2021 08:11:15 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id hs11so120161ejc.1
        for <linux-ext4@vger.kernel.org>; Fri, 12 Feb 2021 08:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+yuoz+Hc/nf6Qi7lvOfyYwxP2lLDolo0NsLOOXT/hc=;
        b=QIX+6R++QbTXtV4IM/F8oRaRw32M4v+YSSrZZmbVm++0Fvrfmd7DE/lPf09aiZm+9U
         EpgEd40dVlA0i4j9q6f/zkhuchn/TG/L4OF/Hlw1HCIiWa+U735m4thuQOh46bj7py/d
         gmj1UzuQgws2hEcGjen50+shH9lRJkJTMbVGeS+N0KQwLNKF4hyhPfvy585/aCdrZPhR
         ZBdXx3uhNwBSUz7q8pStzu4UigR3lyd+lcjG2Cw1jj1bET6UGh9B49F4YxrRdTTv1qR1
         hkc42BnR7GWegFspZpt/Dn39E9gcIHSZU7GmtBALjXNSLujwOtbmp+LN/r4NnFVvYlO0
         MBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+yuoz+Hc/nf6Qi7lvOfyYwxP2lLDolo0NsLOOXT/hc=;
        b=K/FuvSNHmXSqRd5b9K+JTEtOFbw4AdKTITSCUNNEgrSsgalJSodCmIW4Sx1Qsn+nP0
         byY7uPMp1owXeg7V7b/6i56PAhuWO/HRNGlA8FjxvRrT+ico8cgBwtS8l5FA35zDHa+o
         EpBUtDLd++ccue67Jwq8ekXHyD5RJPdx/Dmc5t4S4pdoZ1mpPDJ5tuoHgwP4gZOgbn8F
         j18Pl/Nk477MMt2LF1Mnn9ruWagqscomxsbYbbgoo4MTI0uyi4+raMwRn0YVhkIqw3vl
         I0XWlxcvkYLhhdDzr8nkLF1IpGG9/samxSQ+cloaOnc1TG/gUHP0lwWwLtRaIU+NHDoS
         wNNg==
X-Gm-Message-State: AOAM530VANZZRpbhBrqV2dkLoo/1OQDMwbXWjo5Xml80seWAeqniIKP+
        WEz+INRtsIfKUGFn10GutneeZMN6e4QmzAeXTycdKWtc0Ms=
X-Google-Smtp-Source: ABdhPJyVgI9CQl9G0UIeMxRkNsy72TpQND0C1bmzzSX20fK+JWRHu4UTQAotImDpw6Yvs2dQYu3xXrPaDsORUF1WQrs=
X-Received: by 2002:a17:907:9483:: with SMTP id dm3mr3744883ejc.120.1613146274239;
 Fri, 12 Feb 2021 08:11:14 -0800 (PST)
MIME-Version: 1.0
References: <C96ZW60NLAQF.1JF09JLHKR51M@taiga> <YCX+Em/EUJJte3x1@mit.edu> <C97L5DF7C3QF.H25PQ5ERKEPL@taiga>
In-Reply-To: <C97L5DF7C3QF.H25PQ5ERKEPL@taiga>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 12 Feb 2021 08:11:02 -0800
Message-ID: <CAD+ocbxUz1kA_7F3f_xXS6_eVt1c0NeMoMXsBQ7z2LbmrMjgMg@mail.gmail.com>
Subject: Re: j_recover_fast_commit: : failed on musl-riscv64
To:     Drew DeVault <sir@cmpwn.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Drew,

I'd be happy to take a look at this and if you could provide shell
access, that would be great. From the logs you shared above, it looks
like e2fsck is crashing resulting in fast commit recovery being
aborted.

Thanks,
Harshad

On Fri, Feb 12, 2021 at 5:30 AM Drew DeVault <sir@cmpwn.com> wrote:
>
> On Thu Feb 11, 2021 at 11:03 PM EST, Theodore Ts'o wrote:
> > Can you try using glibc on RiscV and see if it passes with glibc?
>
> Hm, I don't have a glibc+RISC-V setup readily available for testing, nor
> could I obtain one easily. But I would be open to offering shell access
> in my musl environment for troubleshooting purposes - would you (or
> any other maintainers) find that helpful?
