Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3337457706
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Nov 2021 20:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhKSTcW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Nov 2021 14:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbhKSTcV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Nov 2021 14:32:21 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CE5C061574
        for <linux-ext4@vger.kernel.org>; Fri, 19 Nov 2021 11:29:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id AF4B51F45CF5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637350158; bh=Cp5u0lgs3VuHtc6UzMsQZYUM+vp88f2hbnH9saBd4+w=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JbcynB2V2r9KDSmJcKb1+WfwP8+4KW2OkQBL0jNGlIwdcSSNp/K5WL0eBInTscN6L
         hKRR8ctTiLGEoifQ3ZYOc2cCNnTl5s5NfubTo/AeJQz3fQrSw1YmTN5X441foM5DDU
         eHpsJgTgOa2coo+t+/miWL4d75wvXpGTzZ0LsLERU3sqff6BE2SeA6i87WTasVXaE5
         3VKRse09q/GeWHX/nbjnIrSd9nYyUslf+iBvu7vnEdYuJDR5ELz7Asa9ox4AeQJYq3
         EAIldXug0kejZ5jxb14oUVi3pUwDymKRhvJCWdQYgIm1nlhCwtc1CBtzkUUMLZb2Cx
         +rTemnq5CgS8A==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Petr Vorel <pvorel@suse.cz>, Jan Kara <jack@suse.com>,
        Matthew Bobrowski <repnop@google.com>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
Organization: Collabora
References: <20211118235744.802584-1-krisman@collabora.com>
        <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com>
Date:   Fri, 19 Nov 2021 14:29:13 -0500
In-Reply-To: <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com>
        (Amir Goldstein's message of "Fri, 19 Nov 2021 07:48:29 +0200")
Message-ID: <8735nsuepi.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Fri, Nov 19, 2021 at 1:57 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
>>
>> Hi,
>>
>> FAN_FS_ERROR was merged into Linus tree, and the PIDFD testcases reached
>> LTP.  Therefore, I'm sending a new version of the FAN_FS_ERROR LTP
>> tests.  This is the v4 of this patchset, and it applies the feedback of
>> the previous version.
>>
>> Thanks,
>>
>> ---
>>
>> Original cover letter:
>>
>> FAN_FS_ERROR is a new (still unmerged) fanotify event to monitor
>> fileystem errors.  This patchset introduces a new LTP test for this
>> feature.
>>
>> Testing file system errors is slightly tricky, in particular because
>> they are mostly file system dependent.  Since there are only patches for
>> ext4, I choose to make the test around it, since there wouldn't be much
>> to do with other file systems.  The second challenge is how we cause the
>> file system errors, since there is no error injection for ext4 in Linux.
>> In this series, this is done by corrupting specific data in the
>> test device with the help of debugfs.
>>
>> The FAN_FS_ERROR feature is flying around linux-ext4 and fsdevel, and
>> the latest version is available on the branch below:
>>
>>     https://gitlab.collabora.com/krisman/linux -b fanotify-notifications-v9
>>
>> A proper manpage description is also available on the respective mailing
>> list, or in the branch below:
>>
>>     https://gitlab.collabora.com/krisman/man-pages.git -b fan-fs-error
>>
>> Please, let me know your thoughts.
>>
>
> Gabriel,
>
> Can you please push these v4 patches to your gitlab tree?

Hi Amir,

I have pushed v4 to :

https://gitlab.collabora.com/krisman/ltp.git -b fan-fs-error_v4

Thank you!

-- 
Gabriel Krisman Bertazi
