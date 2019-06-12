Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B94E642EBC
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jun 2019 20:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfFLScK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Jun 2019 14:32:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47496 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfFLScK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Jun 2019 14:32:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 88A7B260ED4
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
Subject: Re: [PATCH v3 2/2] shared/012: Add tests for filename casefolding feature
Organization: Collabora
References: <20190610173541.20511-1-krisman@collabora.com>
        <20190610173541.20511-2-krisman@collabora.com>
        <20190611121546.GC2774@mit.edu> <85y327z9ad.fsf@collabora.com>
        <20190612123200.GA2736@mit.edu>
Date:   Wed, 12 Jun 2019 14:32:04 -0400
In-Reply-To: <20190612123200.GA2736@mit.edu> (Theodore Ts'o's message of "Wed,
        12 Jun 2019 08:32:00 -0400")
Message-ID: <857e9q8xjv.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Wed, Jun 12, 2019 at 01:01:46AM -0400, Gabriel Krisman Bertazi wrote:
>> > I tried out this test, and it's apparently failing for me using
>> > e2fsprogs 1.45.2; it looks like it's a whitespace issue?
>> 
>> Hi Ted,
>> 
>> Yes, definitely just whitespace.  But i don't understand why you are
>> getting this behavior.  I tried both with the master branch of e2fsprogs
>> and the tagged commit of v1.45.2 and on both occasions the test succeed
>> in my system.  For sure I can use filter_spaces but I'm puzzled why I
>> can't reproduce this.
>
> That's wierd.  The kvm-xfstests appliance VM that's uploaded to
>
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests/
>
> shows the problem.  With your patch applied to the xfstests-dev
> directory after checking out xfstests-bld (see [1] for more
> information if you haven't used kvm-xfstests before), it's reproducible via:
>
> kvm-xfstests -I ../out_dir/root_fs.img.amd64 --update-xfstests-tar -c 4k shared/012
>
> [1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

Hi,

Thanks for the tip.  With my setup, I still can't reproduce it, but I
was able to trigger it with xfstests-bld.  I'll send a follow up patch
that makes the result deterministic, making it work for every scenario.
Later, I'll take a look to see what is missing on my setup to make it
trigger.

-- 
Gabriel Krisman Bertazi
