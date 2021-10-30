Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EACA4407B1
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Oct 2021 08:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhJ3GXz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 Oct 2021 02:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhJ3GXz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 30 Oct 2021 02:23:55 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7265C061570
        for <linux-ext4@vger.kernel.org>; Fri, 29 Oct 2021 23:21:25 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z144so14093748iof.0
        for <linux-ext4@vger.kernel.org>; Fri, 29 Oct 2021 23:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXp4ofDL0qHB+i/D2WT+Gdj9q3TTKFGh/0rQ7NHlnSI=;
        b=Ys+KvZ9OiMAAEFtnSoThgxqQAm+zWG42+03R7WVGztQyYHadMsUfCbIOfcesuEbj51
         //uOQS4zJC4xtVaLoNEb6Y8r+WNhOCbgS9d++aWi8vFf+R5jBAyUtwCPvvl21G8/Pp2h
         UGds6ly6QSlCWPmNvWyYv2imCo9RI4uT+bhBWVDrTBjAjoaFBeEOJTjWBhiqd1H5wEHy
         zQDPKaU+pGYT9MucDAOCCSJEGEYx5/ZIyyd7M9q31Ii7c5B6pG96WqMrHdlZHbD3+RHj
         yUXkozFnQICo2VXDP+1WCI04JmkyG5UcxRBlvpfe+5M8cj1R0Cgr93Lv8EV7j7axqtek
         MnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXp4ofDL0qHB+i/D2WT+Gdj9q3TTKFGh/0rQ7NHlnSI=;
        b=yZS1StcPCqdUJRp+I4/DkMBzh0nHZAaYAqZCk4olACJsVU/h3Fp2JgkSaqSVIcG/L8
         UHB7o/Y+U2OQvPLF+USwIOdnlUkHWHSVKOTayUml8T8nseTvGOvi1mxm9PEH9QuBJiyM
         j3kbc+vDrPCzigQsJVP9g2S9mYNBX0rlybvMR3OVlzgasI8DJhEfjHhv8hp0p8kSQrnv
         ogh+FEYAHYVmhtWCefhZ/KAfVvEVCtWs7UrvGc+f1mPYhUFe9iQ7mVNxBmvCrnXhF/Pe
         GxK8Eh61+nyaYFgLk+chxkClZG8fr2Joq9teZrLl5h6DZxNM2mfWtxzXozkcVt1HZ4kA
         LVRg==
X-Gm-Message-State: AOAM530l25WDVdQxFJ3mKCp6dYdUmV6L3I37eldFU5TF+398XkcEMCOG
        JQowCHGOa3aMhdv/ex/PmAstrzyiqsRWlcaThwdAOrQV
X-Google-Smtp-Source: ABdhPJw6kIhy7/JiL9DoCZQ4LFTrVLfT1piapt7j3fXMPYU7BW/wvUPgducKhnFY8XNj29fz9ck1QaU3Gi5Mzo+X8qo=
X-Received: by 2002:a5d:8792:: with SMTP id f18mr11075862ion.52.1635574885401;
 Fri, 29 Oct 2021 23:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211029211732.386127-1-krisman@collabora.com>
In-Reply-To: <20211029211732.386127-1-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 30 Oct 2021 09:21:15 +0300
Message-ID: <CAOQ4uxhNCWTcp=e7g1giSQixo_bfxre=+6RucY_5RCqNM7ffVg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Test the new fanotify FAN_FS_ERROR event
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, Matthew Bobrowski <repnop@google.com>,
        LTP List <ltp@lists.linux.it>,
        Khazhismel Kumykov <khazhy@google.com>, kernel@collabora.com,
        Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Oct 30, 2021 at 12:17 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Hi,
>
> Now that FAN_FS_ERROR is close to being merged, I'm sending a new
> version of the LTP tests.  This is the v3 of this patchset, and it
> applies the feedback of the previous version, in particular, it solves
> the issue Amir pointed out, that ltp won't gracefully handle a test with
> tcnt==0.  To solve that, I merged the patch that set up the environment
> with a simple test, that only triggers a fs abort and watches the
> event.
>
> I'm also renaming the testcase from fanotify20 to fanotify21, to leave
> room for the pidfs test that is also in the baking by Matthew Bobrowski.

Only Matthew posted two tests... anyway I don't think merge is going to be
a big problem. I am hoping that PIDFD tests could be merged soonish and
I recommended Matthew to base his tests over your first two macro prep
patches.

Thanks,
Amir.
