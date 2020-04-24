Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1571B78BE
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 17:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgDXPBf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Apr 2020 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727804AbgDXPBe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 24 Apr 2020 11:01:34 -0400
X-Greylist: delayed 320 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Apr 2020 08:01:34 PDT
Received: from forward100j.mail.yandex.net (forward100j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045D3C09B045
        for <linux-ext4@vger.kernel.org>; Fri, 24 Apr 2020 08:01:34 -0700 (PDT)
Received: from mxback1j.mail.yandex.net (mxback1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10a])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id 5138850E0C8E
        for <linux-ext4@vger.kernel.org>; Fri, 24 Apr 2020 17:56:10 +0300 (MSK)
Received: from iva6-add863d6e49c.qloud-c.yandex.net (iva6-add863d6e49c.qloud-c.yandex.net [2a02:6b8:c0c:7ea0:0:640:add8:63d6])
        by mxback1j.mail.yandex.net (mxback/Yandex) with ESMTP id tmVIDOZxB9-uAG0vdvK;
        Fri, 24 Apr 2020 17:56:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1587740170;
        bh=yPoKB9MrzR3dJpUElKnFxRCFrfjV9giH9j3qREPEU34=;
        h=Subject:From:To:Date:Message-ID;
        b=K6a4oIx1V1e4cbA27z/lO7eXh54VodsXfNuydvNoVhC6s1sk0q0lNS833/rB8YM/S
         VKEBIGcqIPxZUwusxKJm1JKisFKJTPkhxz4KUWUFqTmmr6sZM6W+QRyk8Ox302/fUN
         0Is1c6n3w7EEJCZevlKXPGFf/JCGUU3COEm73AiQ=
Authentication-Results: mxback1j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva6-add863d6e49c.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 4g9yhZPVbh-u9XGFBak;
        Fri, 24 Apr 2020 17:56:09 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     linux-ext4@vger.kernel.org
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
Subject: Changing a workload results in performance drop
Message-ID: <73a3416a-67d2-c494-1f3f-7d7789bdf61d@yandex.ru>
Date:   Fri, 24 Apr 2020 17:56:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* SSDs are used in testing, so random access is not a concern. But I tried the
   "steps to reproduce" with raw block device, and IOPS always holds 9k for me.
* "Direct" IO is used to bypass file-system cache.
* The issue is way less visible on XFS, so it looks specific to file systems.
* The biggest difference I've seen is on 70% reads/30% writes workload. But for
   simplicity in "steps to reproduce" I'm using 100% write.
* it seems over time (perhaps a day) performance gets improved, so for best
   results when testing that you need to re-create ext4 anew.
* in "steps to reproduce" I grep fio stdout. That suppresses interactive
   output. Interactive output may be interesting though, I've often seen workload
   drops to 600-700 IOPS while average was 5-6k
* Original problem I worked with https://github.com/openzfs/zfs/issues/10231

# Steps to reproduce (in terms of terminal commands)

     $ cat fio_jobfile
     [job-section]
     name=temp-fio
     bs=8k
     ioengine=libaio
     rw=randrw
     rwmixread=0
     rwmixwrite=100
     filename=/mnt/test/file1
     iodepth=1
     numjobs=1
     group_reporting
     time_based
     runtime=1m
     direct=1
     filesize=4G
     $ mkfs.ext4 /dev/sdw1
     $ mount /dev/sdw1 /mnt/test
     $ truncate -s 100G /mnt/test/file1
     $ fio fio_jobfile | grep -i IOPS
       write: IOPS=12.5k, BW=97.0MiB/s (103MB/s)(5879MiB/60001msec)
        iops        : min=10966, max=14730, avg=12524.20, stdev=1240.27, samples=119
     $ sed -i 's/4G/100G/' fio_jobfile
     $ fio fio_jobfile | grep -i IOPS
       write: IOPS=5880, BW=45.9MiB/s (48.2MB/s)(2756MiB/60001msec)
        iops        : min= 4084, max= 6976, avg=5879.31, stdev=567.58, samples=119

## Expected

Performance should be more or less the same

## Actual

The second test is twice as slow

# Versions

* Kernel version: 5.6.2-050602-generic

It seems however that the problem is present at least in 4.19 and 5.4. as well, so not a regression.
