Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4245940A
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Nov 2021 18:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhKVRiO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Nov 2021 12:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhKVRiO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Nov 2021 12:38:14 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D8EC061574
        for <linux-ext4@vger.kernel.org>; Mon, 22 Nov 2021 09:35:06 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 291C51F44A7C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637602505; bh=CH6DK5G3pKGVLoMQePVrma0h6Kl0KQXPzOhitk/dw20=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=joDlYuLd+5HOAi/dO/0ren/v8fUs6oEJzWq8dUY37PRpUE8JHKwZsYuNNDuf7ZzLT
         dzeLGvNsRmgi8MQGUHeJpbuyJXket8ozQxnGurbANWj4BdIMJdquUYssZZXlD1ZJ2q
         tD+DkYk1fJM9EW+xyAlCKRA4DNtSCobDzkkdOf1fI8FixU5jdwd1EYHLFyB6rf7Xd+
         0jzUyxpKrpo1k53BBN5NY5XKYh4pcRLb2h/Ec5YQ0exhwX0B0xnWq7dtxeW1DgMdU6
         le266VlpUAG5X5aLbs7Q1M8toTVl+H4or6sw4PkXiGnwEf/b8Jim9Um3Lr9dNOJRDm
         b3EQyb8RaNdgw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.com>,
        Matthew Bobrowski <repnop@google.com>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
Organization: Collabora
References: <20211118235744.802584-1-krisman@collabora.com>
        <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com>
        <8735nsuepi.fsf@collabora.com> <YZtLDXW01Cz0BfPU@pevik>
Date:   Mon, 22 Nov 2021 12:35:01 -0500
In-Reply-To: <YZtLDXW01Cz0BfPU@pevik> (Petr Vorel's message of "Mon, 22 Nov
        2021 08:47:41 +0100")
Message-ID: <87mtlwt7p6.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Petr Vorel <pvorel@suse.cz> writes:

> Hi all,
>
> <snip>
>> Hi Amir,
>
>> I have pushed v4 to :
>
>> https://gitlab.collabora.com/krisman/ltp.git -b fan-fs-error_v4
>
> FYI I've rebased it on my fix 3b2ea2e00 ("configure.ac: Add struct
> fanotify_event_info_pidfd check")
>
> https://github.com/linux-test-project/ltp.git -b gertazi/fanotify21.v4.fixes
>
> diff to krisman/fan-fs-error_v4:

Petr,

Should I send a v5 or is v4 getting picked up and merged with the fixup
hunk?

Thanks,

-- 
Gabriel Krisman Bertazi
