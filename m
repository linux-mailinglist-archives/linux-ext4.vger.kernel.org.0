Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677E54255C3
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Oct 2021 16:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242179AbhJGOuh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242123AbhJGOug (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 10:50:36 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DA3C061570;
        Thu,  7 Oct 2021 07:48:42 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C3F53218;
        Thu,  7 Oct 2021 14:48:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C3F53218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1633618121; bh=BMhkiifDNAK95tN4yQTlci476ZZmW7sHLau/Ddi/LZ4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ytgmb/Y6gOkv50yDjSaAJjymC+cQ5FyFeXLljA4eujtJUX/ph0XkvEZmDRbGMN8sL
         wOc/xxvBX9/0miJS5gVGIxRm7TwYq9p9VAqaBb/ZKhXBLdQwu7f/rdoMZ+YUpWLZQN
         3yP5MfGCtVAQirc6WVVvofB48Bk1cNk0zxuWGWYjbNEjSZ8EOE+p8tp5qStOd2VyPS
         MAlPMdqJl+rwyLPyam8PTiQI/y6wNXpbnVJ/9t3Y4rIZv6U2KCYJs5IZwbfTBELtQT
         SyvqJNPemeDQqNu+L3a+7Xisiu85RexkWA2D/9yf+Lt8nxWUYL3FhpMUuWDHmDy0xD
         uzMQF9yhvLklg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4: docs: switch away from list-table
In-Reply-To: <YV8EGFcPtM9u+ihl@mit.edu>
References: <20210902220854.198850-1-corbet@lwn.net>
 <20210902220854.198850-2-corbet@lwn.net>
 <20210916095455.GE10610@quack2.suse.cz> <877df9tt5d.fsf@meer.lwn.net>
 <YV8EGFcPtM9u+ihl@mit.edu>
Date:   Thu, 07 Oct 2021 08:48:41 -0600
Message-ID: <87wnmozy9i.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Tue, Sep 21, 2021 at 05:18:06PM -0600, Jonathan Corbet wrote:
>> Jan Kara <jack@suse.cz> writes:
>> 
>> > On Thu 02-09-21 16:08:53, Jonathan Corbet wrote:
>> >> Commit 3a6541e97c03 (Add documentation about the orphan file feature) added
>> >> a new document on orphan files, which is great.  But the use of
>> >> "list-table" results in documents that are absolutely unreadable in their
>> >> plain-text form.  Switch this file to the regular RST table format instead;
>> >> the rendered (HTML) output is identical.
>> >> 
>> >> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>> >
>> > Thanks! Definitely looks more readable :). You can add:
>> >
>> > Reviewed-by: Jan Kara <jack@suse.cz>
>> 
>> Thanks for having a look!  I'll ahead and apply these, then.
>
> Hey Jon,
>
> I don't see these patches in linux-next.  I'm guessing because you
> were busy with some silly thing like LPC.  :-)
>
> Do you want to take them, or I can take them through the ext4 tree.

Ah...I learned something today.  If you try to apply your own patches
with "git am -s" (via b4 to lazily grab Jan's Reviewed-by tags), it
fails, complaining about duplicate signoff lines.  I'd failed to notice
that before.  I've *really* applied them this time (and tweaked my
scripts :).

Thanks,

jon
