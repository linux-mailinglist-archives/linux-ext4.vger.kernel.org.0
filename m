Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1352A43C73D
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Oct 2021 12:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbhJ0KDd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 06:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbhJ0KD0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 06:03:26 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC42C061236
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 03:00:19 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id j3so2320978ilr.6
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 03:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVDq4qGtvBUIvYpOPIZ9ChGPxQN3o9QK0Et0DoTcGwU=;
        b=XN/x9/Q1SJ537/rjg6IB8vGfIF93SaLqygc1HFCyptmeYpOocq0P8B7OBAl0AOQKpe
         pPL5+shyk8R6y7LLi8UMkFz/ib0cBgCttHV1ONLMNY8n3/83ZrcloNnq8n5OFpRBMiiH
         twLvB/mZjg2wlbSF/QYiA+PFcynMOysfMaEs+n/l2sXOJF5TLSfMgzfbuXm2G5n6OxFs
         v6TLOcPe1OEsabnK1rlU3zGBjpE8AMcb2jXPudXBz/osA7IrQEgsjFnlP6A9AiVUJDRd
         lPoen1kiBW4ua82EcAr8Q11CMdoJwu5UJxBCuMzxmmaHmpOpXRnxkYUJFDnqf7Twql9i
         OmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVDq4qGtvBUIvYpOPIZ9ChGPxQN3o9QK0Et0DoTcGwU=;
        b=uPd7zzKEM4vlSFQd7gFGJKAbRjj7Qvq0mmBWOhnaGcmEHApoNIN3foQA/18rWK2uwX
         uBDr0/BnyFMIJ5qdToydqZLJrCupkF0SZ8OUJuJy6QtMDRXqS6mn4TIR/xbHsGcV0Q/H
         cnWpQh5ZjkkCP+h3iCv6cSkjA/lsjUMTxZEJuNgmoBJnSfASlTnAYgVYWveSfpr3HBfE
         PzjxXYPXUrYLLRLxRckVxVs/vK4WmLwlzikaIRl4/Jo5UTqPGjDAWCd7xx4UXxBBoQi1
         FpUYswOBgVZ/rRXhbbYPK/DHVeBWLzx2rEhSBLikIuQBMsU6gYS0aQHuShpbR1j2FM8Y
         IPVA==
X-Gm-Message-State: AOAM530MWWq4CwwaHiQ7AZm4jun2Y+Wm7+6ZBcKscXgz6yV6RXbDentd
        PeiWycDV6tBNX5RRrfxgjcP8VKYGzd6uitF3Ius=
X-Google-Smtp-Source: ABdhPJyCTIYtp5qhPBPELxj29cZ1X8S9hZBdzlU2Bkz8u6Vruts0jrfrSsG+Qdg9xt33e4wtVMZ4SaxS6c+OWFicsaU=
X-Received: by 2002:a92:c083:: with SMTP id h3mr18481400ile.107.1635328818750;
 Wed, 27 Oct 2021 03:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com> <20211026184239.151156-11-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-11-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Oct 2021 13:00:07 +0300
Message-ID: <CAOQ4uxia5Qhieui+keBLumWwGd2+wv88+FykWq-zMrDrHmZUrA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] syscalls/fanotify20: Test capture of multiple errors
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     LTP List <ltp@lists.linux.it>, Jan Kara <jack@suse.com>,
        Khazhismel Kumykov <khazhy@google.com>, kernel@collabora.com,
        Ext4 <linux-ext4@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 26, 2021 at 9:44 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> When multiple FS errors occur, only the first is stored.  This testcase
> validates this behavior by issuing two different errors and making sure
> only the first is stored, while the second is simply accumulated in
> error_count.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  .../kernel/syscalls/fanotify/fanotify20.c     | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index 7bcddcaa98cb..0083a018f2c6 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -78,6 +78,18 @@ static void tcase2_trigger_lookup(void)
>                         ret, BAD_DIR, errno, EUCLEAN);
>  }
>
> +static void tcase3_trigger(void)
> +{
> +       trigger_fs_abort();
> +       tcase2_trigger_lookup();

So after remount,abort filesystem operations can still be executed?
Then I guess my comment from the previous patch about running the test in a loop
is not relevant?

Thanks,
Amir.
