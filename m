Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D761E7889
	for <lists+linux-ext4@lfdr.de>; Fri, 29 May 2020 10:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgE2Iju convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 29 May 2020 04:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2Ijt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 May 2020 04:39:49 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA91C03E969;
        Fri, 29 May 2020 01:39:49 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:51136)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <janneke@gnu.org>)
        id 1jeaYK-000171-17; Fri, 29 May 2020 04:39:44 -0400
Received: from [2001:980:1b4f:1:42d2:832d:bb59:862] (port=36364 helo=dundal.peder.onsbrabantnet.nl)
        by fencepost.gnu.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <janneke@gnu.org>)
        id 1jeaYJ-0002yQ-G1; Fri, 29 May 2020 04:39:43 -0400
From:   Jan Nieuwenhuizen <janneke@gnu.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Danny Milosavljevic <dannym@scratchpost.org>,
        Samuel Thibault <samuel.thibault@gnu.org>
Subject: Re: [PATCH v2] ext4: support xattr gnu.* namespace for the Hurd
Organization: AvatarAcademy.nl
References: <20200525193940.878-1-janneke@gnu.org>
        <20200529032505.GM228632@mit.edu>
X-Url:  http://AvatarAcademy.nl
Date:   Fri, 29 May 2020 10:39:39 +0200
In-Reply-To: <20200529032505.GM228632@mit.edu> (Theodore Y. Ts'o's message of
        "Thu, 28 May 2020 23:25:05 -0400")
Message-ID: <87imgfuoc4.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Theodore Y. Ts'o writes:

Hello!

> On Mon, May 25, 2020 at 09:39:40PM +0200, Jan (janneke) Nieuwenhuizen wrote:
>> The Hurd gained[0] support for moving the translator and author
>> fields out of the inode and into the "gnu.*" xattr namespace.
>> 
>> In anticipation of that, an xattr INDEX was reserved[1].  The Hurd has
>> now been brought into compliance[2] with that.
>> 
>> This patch adds support for reading and writing such attributes from
>> Linux; you can now do something like

[...]
>
> This patch is missing a Signed-off-by.  If you don't understand why
> this is really important, please read: 
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Ah, that makes sense.  Sorry for omitting that/being not clear on it.

> Can you resubmit with the DCO or confirm that it's OK for me to add
> your Signed-off-by?

Yes, that's OK, please do!  I am the original author of this patch.

Greetings,
Janneke

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond http://lilypond.org
Freelance IT http://JoyofSource.com | Avatar® http://AvatarAcademy.com
