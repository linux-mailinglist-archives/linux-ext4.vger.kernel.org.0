Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 572F412E586
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jan 2020 12:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgABLIb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Jan 2020 06:08:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36921 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728144AbgABLIa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Jan 2020 06:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577963309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GNvakkxQuOqMQUj1eGVGpZIiH2Cj2LW8lOBGntXxElo=;
        b=hkKZsfFnywJsWJIsUL5U0nawEhgntgHmgMyLGvQAjiGNCFtE1ZmKuay5Q1ex65sXh0Ya/Q
        1Hb1RQ0ZU7JoiibhmBv0xNnteNDKOqxyrTadBE6Zj1nUMf0U5B4dlxcDCRIrIhpwkCNX5p
        UH1w8mKuqCk4TFa7gloWYBsLNCJOrqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-kZSTbWABO1GvDq5y6MrkwQ-1; Thu, 02 Jan 2020 06:08:22 -0500
X-MC-Unique: kZSTbWABO1GvDq5y6MrkwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25F0B800D4C;
        Thu,  2 Jan 2020 11:08:21 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-196.brq.redhat.com [10.40.204.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 123CB1A7E4;
        Thu,  2 Jan 2020 11:08:19 +0000 (UTC)
Date:   Thu, 2 Jan 2020 12:08:17 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     util-linux@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: [bugreport] "hwclock -w" reset time instead of setting the right
 time
Message-ID: <20200102110817.ahqaqidw3ztw3kax@10.255.255.10>
References: <CABXGCsODr3tMpQxJ_nhWQQg5WGakFt4Yu5B8ev6ErOkc+zv9kA@mail.gmail.com>
 <20200101141748.GA191637@mit.edu>
 <CABXGCsOv26W6aqB5WPMe-mEynmwy55DTfTeL5Dg9vRq6+Y6WvA@mail.gmail.com>
 <CABXGCsNkzPrjqMRaWpssorxzhMLWBvLeSw9BpKYr_DW4LJQECQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsNkzPrjqMRaWpssorxzhMLWBvLeSw9BpKYr_DW4LJQECQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 02, 2020 at 01:08:41PM +0500, Mikhail Gavrilov wrote:
> "hwclock -w" reset time instead of setting the right time on M/B "ROG
> Strix X570-I Gaming"
> Demonstration: https://youtu.be/QRB7ZLiEfrc
> Some DE like GNOME has automatic time synchronization option and there
> is a feeling that hardware time reset after each Linux boot.

 Can you try "hwclock -w -v" to get more details?

 For example on my workstation:

        # ./hwclock -w -v
        hwclock from util-linux 2.35-rc1-20-63f8
        System Time: 1577963091.683987
        Trying to open: /dev/rtc0
        Using the rtc interface to the clock.
        Last drift adjustment done at 1531914946 seconds after 1969
        Last calibration done at 1531914946 seconds after 1969
        Hardware clock is on UTC time
        Assuming hardware clock is kept in UTC time.
        RTC type: 'rtc_cmos'
        Using delay: 0.500000 seconds
        missed it - 1577963091.684767 is too far past 1577963091.500000 (0.184767 > 0.001000)
        1577963092.500000 is close enough to 1577963092.500000 (0.000000 < 0.002000)
        Set RTC to 1577963092 (1577963091 + 1; refsystime = 1577963091.000000)
        Setting Hardware Clock to 11:04:52 = 1577963092 seconds since 1969
        ioctl(RTC_SET_TIME) was successful.
        Not adjusting drift factor because the --update-drift option was not used.
        New /etc/adjtime data:
        0.000000 1577963091 0.000000
        1577963091
        UTC


    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

