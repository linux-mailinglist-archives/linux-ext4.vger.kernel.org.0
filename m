Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF2E4463BE
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Nov 2021 14:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhKENFT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Nov 2021 09:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhKENFS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Nov 2021 09:05:18 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC9FC061714
        for <linux-ext4@vger.kernel.org>; Fri,  5 Nov 2021 06:02:39 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id w15so9395849ill.2
        for <linux-ext4@vger.kernel.org>; Fri, 05 Nov 2021 06:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14covRk9VIqYx+iigWd5Oy3gFSROrP7x153m363/8ps=;
        b=Sd92rfbwRkHR8aJHxXi8loHqRp4nbuHCTpo/jn9VFJjgQC8w8GWZYDg2LE0o5qc+Md
         k2wpeFSyYQXso7jRgO1iL/PjGpsWI6bSICznUfCXyImXXxyFotMzs0f6MuAAiXqBjiDU
         hAo3vUet1HJqPIMIpahXOTNFZhSYA/Mcup80X5aA9eCVrfVvKIK6+hYPYPM+WtrKRcMT
         QcEb4qcI9bfnVr5bAdXrj6iRLc/PBd4KGH1zAtDIAj5emkKjubJwHdiWsOCyA8vBx+AO
         CWQ8/PG+2xxAIPrX14qY88mltIZijg/NMwB+vsfsEYuPw2PkHQu0YdrMpDTPRHFwGOHM
         RUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14covRk9VIqYx+iigWd5Oy3gFSROrP7x153m363/8ps=;
        b=tnmUWZ/rlu/hwDDvkTK1zBJgUSMWJ9hzfEGpxr8YZe2ywFZcZw9xed1wcLDiQJOvCr
         AdmdyH9xib1k4E9AGPBmra3UhE9D8c8rK94lrKsIQuXqG84Pdrf1Rn5p85iaSsCE8EKR
         zLhY2J6HecwnRjNAZDY4H8CRRvs8tStX3jCqDsATv27VGImWC70dP10hetZBgymDH8Oc
         U9kqKp4bRicd2w9dvsMEgM4atWGWVWbJ5SWWtTWoocS6BnXULntJbXerqy5rB8myQfKu
         LgQ3FrRJvcdk+BXjq5woH0xXjYjTUenf6WVCf9ETu+5m/VmjGtc7udLObxCFz21ZoiPp
         RSKQ==
X-Gm-Message-State: AOAM532nvxUMJcYmSKBM4GKfT0Iw0S3Bz2c+HIAOCDmjCHdubJ3jjYoQ
        PwkFxrXbDLq3Z/7vNYN4ob4GcGhHxwTh2UtP9ytifp4k
X-Google-Smtp-Source: ABdhPJzpb0s/WltSrwq1p22I96wtFs2wQzG8uEBugl+1nqp7MIcWYhNBh48j/VFu542v/NJdUcFkMAE2qobDaVm4Rpc=
X-Received: by 2002:a92:d643:: with SMTP id x3mr39918549ilp.107.1636117357737;
 Fri, 05 Nov 2021 06:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211029211732.386127-1-krisman@collabora.com> <YYUDDU0A9hLFbM4c@pevik>
In-Reply-To: <YYUDDU0A9hLFbM4c@pevik>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 5 Nov 2021 15:02:26 +0200
Message-ID: <CAOQ4uxjpfmhC722jXban2jfSKT+xYQOyaG8OnwuphqM_G_HZ0A@mail.gmail.com>
Subject: Re: [LTP] [PATCH v3 0/9] Test the new fanotify FAN_FS_ERROR event
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        Matthew Bobrowski <repnop@google.com>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 5, 2021 at 12:10 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Gabriel, all,
>
> > Hi,
>
> > Now that FAN_FS_ERROR is close to being merged, I'm sending a new
> > version of the LTP tests.  This is the v3 of this patchset, and it
> > applies the feedback of the previous version, in particular, it solves
> > the issue Amir pointed out, that ltp won't gracefully handle a test with
> > tcnt==0.  To solve that, I merged the patch that set up the environment
> > with a simple test, that only triggers a fs abort and watches the
> > event.
>
> > I'm also renaming the testcase from fanotify20 to fanotify21, to leave
> > room for the pidfs test that is also in the baking by Matthew Bobrowski.
>
> > One important detail is that, for the tests to succeed, there is a
> > dependency on an ext4 fix I sent a few days ago:
>
> > https://lore.kernel.org/linux-ext4/20211026173302.84000-1-krisman@collabora.com/T/#u
> It has been merged into Theodore Ts'o ext4 tree into dev branch as c1e2e0350ce3
> ("ext4: Fix error code saved on super block during file system abort")
>
> We should probably add it as .tags (see fanotify06.c).

No point in doing that.
There will be no kernel release which meets the test requirements
and has this bug.

Thanks,
Amir.
