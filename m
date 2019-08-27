Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE68C9DD69
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2019 08:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfH0GG6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Aug 2019 02:06:58 -0400
Received: from mail.aixigo.de ([5.145.142.10]:40206 "EHLO mail.aixigo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfH0GG6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 27 Aug 2019 02:06:58 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2019 02:06:57 EDT
Received: from srvvm01.ac.aixigo.de (mail.ac.aixigo.de [172.19.96.11])
        by gate5a.ac.aixigo.de (OpenSMTPD) with ESMTPS id c965f4ed (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-ext4@vger.kernel.org>;
        Tue, 27 Aug 2019 08:00:15 +0200 (CEST)
Received: from dpcl082.ac.aixigo.de (dpcl082.ac.aixigo.de [172.19.97.128])
        by srvvm01.ac.aixigo.de (8.15.2/8.15.2/Debian-8) with ESMTP id x7R60EJk3921397;
        Tue, 27 Aug 2019 08:00:15 +0200
To:     linux-ext4@vger.kernel.org
From:   Harald Dunkel <harald.dunkel@aixigo.com>
Subject: fsck on ext4: "WARN Wrong bounce buffer write length: 1024 != 0"
Message-ID: <22367f07-3448-f771-0363-b5c6f500b77d@aixigo.com>
Date:   Tue, 27 Aug 2019 08:00:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.101.1 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

FYI: "fsck -y" on an external USB drive (USB-C, ext4) gave
me a ton of messages

:
[  191.261939] xhci_hcd 0000:05:00.0: WARN Wrong bounce buffer write length: 1024 != 0
[  191.263743] xhci_hcd 0000:05:00.0: WARN Wrong bounce buffer write length: 1024 != 0
[  191.263788] xhci_hcd 0000:05:00.0: WARN Wrong bounce buffer write length: 1024 != 0
[  191.263840] xhci_hcd 0000:05:00.0: WARN Wrong bounce buffer write length: 1024 != 0
[  191.266857] xhci_hcd 0000:05:00.0: WARN Wrong bounce buffer write length: 1024 != 0
:

Related to 597c56e372dab2c7f79b8d700aad3a5deebf9d1b, AFAICT.

Kernel is 4.19.67-1 (Debian proposed-updates).


Regards
Harri
