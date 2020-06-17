Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A3E1FD500
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jun 2020 21:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgFQTBe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Jun 2020 15:01:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38798 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726835AbgFQTBe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 17 Jun 2020 15:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592420492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jPhkwrTopMSFWHY/7yIdQhPMl7mJcTG6ZU5FGnkE1JY=;
        b=U2k7TTCGGlZaTsesZruGxjeVo+b/quTA7jKPivQkk5zIcBgjm2cY5ytQoGXs02oup85xaw
        yPeaRmMJyRzVsuHKbb54UOAQ2tYNfqr4xon6U+iv7+0rzZEV+kxlkwo0fit2kLrf4lo1tc
        /SCopy5kI2DJgVb6Xq2OQzNZQhem/D4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-ivip1b6TN5y3jAzIhkU_Cg-1; Wed, 17 Jun 2020 15:01:31 -0400
X-MC-Unique: ivip1b6TN5y3jAzIhkU_Cg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D14D1800D42
        for <linux-ext4@vger.kernel.org>; Wed, 17 Jun 2020 19:01:30 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0DFE5C1D6
        for <linux-ext4@vger.kernel.org>; Wed, 17 Jun 2020 19:01:29 +0000 (UTC)
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
From:   Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 0/1] ext4: fix potential negative array index in do_split
Message-ID: <d08d63e9-8f74-b571-07c7-828b9629ce6a@redhat.com>
Date:   Wed, 17 Jun 2020 14:01:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We recently had a report of a panic in do_split; the filesystem in question
panicked a distribution kernel when trying to add a new directory entry;
the behavior/bug persists upstream.

The directory block in question had lots of unused and un-coalesced
entries, like this, printed from the loop in ext4_insert_dentry():

[32778.024654] reclen 44 for name len 36
[32778.028745] start: de ffff9f4cb5309800 top ffff9f4cb5309bd4
[32778.034971]  offset 0 nlen 28 rlen 40, rlen-nlen 12, reclen 44 name <empty>
[32778.042744]  offset 40 nlen 28 rlen 28, rlen-nlen 0, reclen 44 name <empty>
[32778.050521]  offset 68 nlen 32 rlen 32, rlen-nlen 0, reclen 44 name <empty>
[32778.058294]  offset 100 nlen 28 rlen 28, rlen-nlen 0, reclen 44 name <empty>
[32778.066166]  offset 128 nlen 28 rlen 28, rlen-nlen 0, reclen 44 name <empty>
[32778.074035]  offset 156 nlen 28 rlen 28, rlen-nlen 0, reclen 44 name <empty>
[32778.081907]  offset 184 nlen 24 rlen 24, rlen-nlen 0, reclen 44 name <empty>
[32778.089779]  offset 208 nlen 36 rlen 36, rlen-nlen 0, reclen 44 name <empty>
[32778.097648]  offset 244 nlen 12 rlen 12, rlen-nlen 0, reclen 44 name REDACTED
[32778.105227]  offset 256 nlen 24 rlen 24, rlen-nlen 0, reclen 44 name <empty>
[32778.113099]  offset 280 nlen 24 rlen 24, rlen-nlen 0, reclen 44 name REDACTED
[32778.122134]  offset 304 nlen 20 rlen 20, rlen-nlen 0, reclen 44 name REDACTED
[32778.130780]  offset 324 nlen 16 rlen 16, rlen-nlen 0, reclen 44 name REDACTED
[32778.138746]  offset 340 nlen 24 rlen 24, rlen-nlen 0, reclen 44 name <empty>
[32778.146616]  offset 364 nlen 28 rlen 28, rlen-nlen 0, reclen 44 name <empty>
[32778.154487]  offset 392 nlen 24 rlen 24, rlen-nlen 0, reclen 44 name <empty>
[32778.162362]  offset 416 nlen 16 rlen 16, rlen-nlen 0, reclen 44 name <empty>
...

the file we were trying to insert needed a record length of 44, and none of the
non-coalesced <empty> slots were big enough, so we failed and told do_split
to get to work.

However, the sum of the non-empty entries didn't exceed half the block size, so
the loop in do_split() iterated over all of the entries, ended at "count," and
told us to split at (count - move) which is zero, and eventually:

        continued = hash2 == map[split - 1].hash;

exploded on the negative index.

It's an open question as to how this directory got into this format; I'm not
sure if this should ever happen or not.  But at a minimum, I think we should
be defensive here, hence [PATCH 1/1] will do that as an expedient fix and
backportable patch for this situation.  There may be some other underlying 
probem which led to this directory structure if it's unexpected, and maybe that
can come as another patch if anyone can investigate.

Thanks,
-Eric

