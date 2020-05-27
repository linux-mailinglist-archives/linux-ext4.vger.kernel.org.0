Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEC31E3D9D
	for <lists+linux-ext4@lfdr.de>; Wed, 27 May 2020 11:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgE0JcG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 May 2020 05:32:06 -0400
Received: from mail.thelounge.net ([91.118.73.15]:52799 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgE0JcF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 May 2020 05:32:05 -0400
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 49X5FZ3DSLzXSL;
        Wed, 27 May 2020 11:32:02 +0200 (CEST)
Subject: Re: [PATCH] ext4: introduce EXT4_BG_WAS_TRIMMED to optimize trim
To:     Lukas Czerner <lczerner@redhat.com>,
        Wang Shilong <wangshilong1991@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Wang Shilong <wshilong@ddn.com>,
        Shuichi Ihara <sihara@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>
References: <1590565130-23773-1-git-send-email-wangshilong1991@gmail.com>
 <20200527091938.647363ekmnz7av7y@work>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <520b260b-13e9-4c62-eaeb-c44215b14089@thelounge.net>
Date:   Wed, 27 May 2020 11:32:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527091938.647363ekmnz7av7y@work>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



Am 27.05.20 um 11:19 schrieb Lukas Czerner:
> On Wed, May 27, 2020 at 04:38:50PM +0900, Wang Shilong wrote:
>> From: Wang Shilong <wshilong@ddn.com>
>>
>> Currently WAS_TRIMMED flag is not persistent, whenever filesystem was
>> remounted, fstrim need walk all block groups again, the problem with
>> this is FSTRIM could be slow on very large LUN SSD based filesystem.
>>
>> To avoid this kind of problem, we introduce a block group flag
>> EXT4_BG_WAS_TRIMMED, the side effect of this is we need introduce
>> extra one block group dirty write after trimming block group.

would that also fix the issue that *way too much* is trimmed all the
time, no matter if it's a thin provisioned vmware disk or a phyiscal
RAID10 with SSD

no way of 315 MB deletes within 2 hours or so on a system with just 485M
used

[root@firewall:~]$  fstrim -av
/boot: 0 B (0 bytes) trimmed on /dev/sda1
/: 315.2 MiB (330522624 bytes) trimmed on /dev/sdb1

[root@firewall:~]$  df
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/sdb1      ext4  5.8G  463M  5.4G   8% /
/dev/sda1      ext4  485M   42M  440M   9% /boot
