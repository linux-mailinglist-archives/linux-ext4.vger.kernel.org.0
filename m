Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021F64A7625
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Feb 2022 17:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345983AbiBBQpa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Feb 2022 11:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiBBQp3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Feb 2022 11:45:29 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFBFC061714
        for <linux-ext4@vger.kernel.org>; Wed,  2 Feb 2022 08:45:29 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 744211F44994
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643820327;
        bh=QGhPBZ5UqGHJzYqFmfNE2i/ZkVErlT75jg/7lW6yZeY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=C24LCKfXFpvHjPC+89u7IWLr4z/dhbD+NmT8OoBWv7+65te+q+6rE60OBwvPhwtFQ
         8D2cFzpG4Fp/norxRo/4xlHeO7+golXBZeQZ7hTjdReMeDEN49anSB0TzjM+i92F9D
         fL1mU/PEg33kfwNC1hDG90YOCvV08pBCLBgJ25UhlD5YWIGM0w6kmOGUMv8PfCdhHq
         8gflEXMfw9sPBONHcY2ne3lU08XpKmyOguQ1FykeI+xgsP5MecQT2Af3xMNPIz78Ra
         DJk3qCbz7k7oaSeRyOYwMgP8PMcdOjZWZPC3rrUEaJhSYJQ69kGLJjcVX0xVMBhnAf
         ExwMbtPer2GvA==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Petr Vorel <pvorel@suse.cz>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
Organization: Collabora
References: <20211118235744.802584-1-krisman@collabora.com>
        <YdxN6HBJF+ATgZxP@pevik>
        <CAOQ4uxia2NNMPUCQzjo6Gsnz8xr_9YKTeTqzOu-hgdsjfHHx0w@mail.gmail.com>
        <CAASaF6xQG691q9JxiEF5HgqCNfGd1FHhwEX5TG_WpW3rHpBFKQ@mail.gmail.com>
Date:   Wed, 02 Feb 2022 11:45:24 -0500
In-Reply-To: <CAASaF6xQG691q9JxiEF5HgqCNfGd1FHhwEX5TG_WpW3rHpBFKQ@mail.gmail.com>
        (Jan Stancek's message of "Wed, 2 Feb 2022 15:10:26 +0100")
Message-ID: <875ypxgqu3.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Jan Stancek <jstancek@redhat.com> writes:

> On Wed, Feb 2, 2022 at 2:49 PM Amir Goldstein <amir73il@gmail.com> wrote:
>> Guys,
>>
>> Looks like we have a regression.
>
> agreed, "abort" option stopped working:
> https://gitlab.com/cki-project/kernel-tests/-/issues/945
>
> Lukas pointed out this patch that didn't make it in yet:
> https://lkml.org/lkml/2021/12/21/384
> This should be new version:
> https://lore.kernel.org/linux-ext4/YcSYvk5DdGjjB9q%2F@mit.edu/T/#t

I gave this patch a try and verified it fixes the test case regression.
Let me ask Ted to make sure it is merged for the 5.17 release.

Thanks,

-- 
Gabriel Krisman Bertazi
