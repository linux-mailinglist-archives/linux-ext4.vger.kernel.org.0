Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871E93E1E24
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Aug 2021 23:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhHEVue (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Aug 2021 17:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhHEVud (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Aug 2021 17:50:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F3CC0613D5
        for <linux-ext4@vger.kernel.org>; Thu,  5 Aug 2021 14:50:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 8988E1F44365
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     LTP List <ltp@lists.linux.it>, Jan Kara <jack@suse.com>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>, kernel@collabora.com
Subject: Re: [PATCH 6/7] syscalls/fanotify20: Test file event with broken inode
Organization: Collabora
References: <20210802214645.2633028-1-krisman@collabora.com>
        <20210802214645.2633028-7-krisman@collabora.com>
        <CAOQ4uxizX0ar7d9eYgazcenQcA7Ku7quEZOLbcaxKJiY0sTPLA@mail.gmail.com>
        <87k0l1hkuz.fsf@collabora.com>
        <CAOQ4uxis23+T3=+R+9rKkxtZLtS4S4LJ6RBgG0AEHsg4=MJyRA@mail.gmail.com>
Date:   Thu, 05 Aug 2021 17:50:11 -0400
In-Reply-To: <CAOQ4uxis23+T3=+R+9rKkxtZLtS4S4LJ6RBgG0AEHsg4=MJyRA@mail.gmail.com>
        (Amir Goldstein's message of "Wed, 4 Aug 2021 08:27:46 +0300")
Message-ID: <87tuk3ef3g.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Hi Amir,

thanks for the review.

Amir Goldstein <amir73il@gmail.com> writes:
> Well, I would not expect a FAN_FS_ERROR event to ever have 0 error
> value. Since this test practically only tests ext4, I do not think it
> is reasonable
> for the test to VERIFY a bug. It is fine to write this test with expectations
> that are not met and let it fail.

This gave me a good chuckle. :)  I will check for a
EXT4_ERR_EFSCORRUPTED and propose a fix on ext4.

>
> But a better plan would probably be to merge the patches up to 5 to test
> FAN_FS_ERROR and then add more test cases after ext4 is fixed
> Either that or you fix the ext4 problem along with FAN_FS_ERROR.
>
> Forgot to say that the test needs to declare .needs_cmds "debugfs".
>
> In any case, as far as prerequisite to merging FAN_FS_ERROR
> your WIP tests certainly suffice.
> Please keep your test branch around so we can use it to validate
> the kernel patches.
> I usually hold off on submitting LTP tests for inclusion until at least -rc3
> after kernel patches have been merged.

As requested, I will not send a new version of the test for now. I
published them on the following unstable branch:

  https://gitlab.collabora.com/krisman/ltp -b fan-fs-error

The v1, as submitted in this thread is also available at:

  https://gitlab.collabora.com/krisman/ltp -b fan-fs-error-v1

Thanks,

-- 
Gabriel Krisman Bertazi
