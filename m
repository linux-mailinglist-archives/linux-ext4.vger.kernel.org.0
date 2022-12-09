Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2280A6482E6
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Dec 2022 14:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLINrw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Dec 2022 08:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLINrv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Dec 2022 08:47:51 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F80396C4
        for <linux-ext4@vger.kernel.org>; Fri,  9 Dec 2022 05:47:48 -0800 (PST)
Received: (Authenticated sender: gabriel@krisman.be)
        by mail.gandi.net (Postfix) with ESMTPSA id 31DD51BF207;
        Fri,  9 Dec 2022 13:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
        t=1670593666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+rKQmaQriEX7XnldoSzk56zNLF0zT0xTnNbdoxc3XiY=;
        b=RJRe/h7nXSXyFpHYeA8YZHnwGpXNox2c5FCAHXaTVd4aqjHXtPC/z9GRr5Pl85xBnBTbyX
        3JtJEZsNbZvS1EuyfWeFdOxGtTQPiQuGxMdr133LGLFhn/R0eOkQ7QSAzJ8fRsaBla/XBz
        S1ue/jg4rGVTUjG+5EPveIVFqzJts3HwCZmt8Bj1u+V+0BXhKHqDGq74bAvvG4Wi0iBsmh
        oYsg2Szvvu5uf3CqBp0jgMpKz8DrgBTCQ5uTPihqCXA+8ogbzL87BOdVBAQh2/bJJSVCOb
        Mxillg4jZWxw/JKCqk2qadCUG2OK+uIA677sHIq9Z4IuR420jjLT4zySnVrwfw==
From:   Gabriel Krisman Bertazi <gabriel@krisman.be>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     tytso@mit.edu, Eric Biggers <ebiggers@kernel.org>,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v9 0/8] Clean up the case-insensitive lookup path
References: <20220913234150.513075-1-krisman@collabora.com>
        <Yy0t8WYhM+Dv3gX1@sol.localdomain> <87fsgi2lax.fsf@collabora.com>
        <87tu47thie.fsf@suse.de>
        <2859a108-3189-6407-2d11-6b9f0948f718@collabora.com>
Date:   Fri, 09 Dec 2022 10:47:37 -0300
In-Reply-To: <2859a108-3189-6407-2d11-6b9f0948f718@collabora.com> (Muhammad
        Usama Anjum's message of "Thu, 8 Dec 2022 19:38:46 +0500")
Message-ID: <871qp8n0xy.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Muhammad Usama Anjum <usama.anjum@collabora.com> writes:

> On 10/14/22 4:45 AM, Gabriel Krisman Bertazi wrote:
>> Gabriel Krisman Bertazi <krisman@collabora.com> writes:
>> 
>>> Eric Biggers <ebiggers@kernel.org> writes:
>>>
>>>> On Tue, Sep 13, 2022 at 07:41:42PM -0400, Gabriel Krisman Bertazi wrote:
>>>>> Hi,
>>>>>
>>>>> I'm resubmitting this as v9 since I think it has fallen through the
>>>>> cracks :).  It is a collection of trivial fixes for casefold support on
>>>>> ext4/f2fs. More details below.
>>>>>
>>>>> It has been sitting on the list for a while and most of it is r-b
>>>>> already. I'm keeping the tags for this submission, since there is no
>>>>> modifications from previous submissions, apart from a minor conflict
>>>>> resolution when merging to linus/master.
>>>>
>>>> Who are you expecting to apply this?
>>>
>>> Hi Eric,
>>>
>>> There are three groups of changes here: libfs, ext4 and f2fs.  Since the
>>> changes in libfs are self-contained and only affect these two
>>> filesystems, I think it should be fine for them to go through a fs tree.
>>>
>>> The bulk of changes are ext4, and Ted mentioned on an earlier version
>>> that he could pick the first patches of this series, so I'm thinking it
>>> should all go through the ext4 tree.  If Jaegeuk acks, the f2fs changes
>>> are safe to go with the rest, or I can send them afterwards as a
>>> separate series once the libfs code is merged.
>> 
>> Ted,
>> 
>> Does the above plan work for you? Do you intend to pick this up for the
>> next merge window?
> It seems like this series hasn't been picked up. Any ideas on what can
> be done?

I got tired of the radio silence and gave up on it.  If there is interest,
feel free to respin it once more.

-- 
Gabriel Krisman Bertazi
