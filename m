Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005AB4A71F6
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Feb 2022 14:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbiBBNth (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Feb 2022 08:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiBBNth (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Feb 2022 08:49:37 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6C8C061714
        for <linux-ext4@vger.kernel.org>; Wed,  2 Feb 2022 05:49:36 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id 15so17060260ilg.8
        for <linux-ext4@vger.kernel.org>; Wed, 02 Feb 2022 05:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXZdCtyffwL4vCc6tPbTtK79j9gtn5iG0VXS2LnY834=;
        b=BwaIgE3LKN9ZF0ds7GsfEMRubG61ipkFszlhwVOSbdPV3aMgRaveZCSpjdXAkCkLXc
         plubooe+bwRQmWOgLpFlkZgmGpC0KbF4kmCNbZcSmFhGHGSlZtKK2NZ92AzM60+h/E16
         IhaRBKGuLsR7r0lBNyJMsW0zRgDlrIiAIrQbuX0YecZuMBHmqZAYNYUtzMnTQt315ygv
         hwfQEG4df/bL9xZMGAzhGG5s6YsQiu01k8zWSuLlgqTPsDyyoSRulmkwPtOmzZv3vXo1
         T8MUCd8fEv8L5QB3xsimdLEdQKN6jfRx2lkmkFXdwun1xtV5vSuLfkIuTJdSHG9FaUp6
         uN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXZdCtyffwL4vCc6tPbTtK79j9gtn5iG0VXS2LnY834=;
        b=bCzxQMy2iszKBtna9DLtdkmBgBBvqr3ZBF+8VAAJvT1nECk6F9tOkF0YYlYC0g7Jwd
         XVKWV6ZXoxSJwUbgvHiGop0gY77oE67ezxSerx6HvTE+JGlVS4yE1SLY2J4FRRLSVhef
         9gvQl1pBwyc2YfFHzxptFVqWzt9i9Psya9syaHMfkiknwTH5kGsStDxe7V5I1eHqZiAJ
         VDfaUQ1V+X1ydrHFbbwrI8XIbG0OGoZIkrRR8HK1eltMpeg2h8O66hi4QDU0+w3WfSm2
         LlpNyJWk29RldC6jmFNT7XopgbgvsgtxXzt1dM4jYgGMLX0qTRulwZpckVXUhfyjNkLT
         /urw==
X-Gm-Message-State: AOAM530ENanjM/TV2yPhwmmErfhuERi4fn/cstxdXdjekjHmcXFOENZ+
        xedfapPzHF2gz2+VWi6YIfZpbVC3rPV1tu2rZUU=
X-Google-Smtp-Source: ABdhPJx1FQImVhmi2FyjUGW44ZE7PEXt6lJs6jbJyL90VmbF2fpIq9L6iSexL8uEYxQUuobpwxaiCKdw6WiNN1f4ajM=
X-Received: by 2002:a05:6e02:1b85:: with SMTP id h5mr18702420ili.107.1643809776280;
 Wed, 02 Feb 2022 05:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20211118235744.802584-1-krisman@collabora.com> <YdxN6HBJF+ATgZxP@pevik>
In-Reply-To: <YdxN6HBJF+ATgZxP@pevik>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 2 Feb 2022 15:49:25 +0200
Message-ID: <CAOQ4uxia2NNMPUCQzjo6Gsnz8xr_9YKTeTqzOu-hgdsjfHHx0w@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
To:     Petr Vorel <pvorel@suse.cz>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, Matthew Bobrowski <repnop@google.com>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jan 10, 2022 at 5:16 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi all,
>
> v5.16 released => patchset merged.
> Thanks!
>

Guys,

Looks like we have a regression.
With kernel v5.17-rc1, test fanotify22 blocks on the first test case,
because the expected ECORRUPTED event on remount,abort is never received.
The multiple error test cases also fail for the same reason.

Gabriel,

Are you aware of any ext4 change that could explain this regression?

In any case, Petr, I suggest adding a short timeout to the test
instead of the default 5min.
Test takes less than 1 second on my VM on v5.16, so...

Thanks,
Amir.
