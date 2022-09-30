Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9905F036C
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Sep 2022 05:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiI3DtQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 23:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiI3DtP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 23:49:15 -0400
X-Greylist: delayed 135 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Sep 2022 20:49:12 PDT
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9B81E277C;
        Thu, 29 Sep 2022 20:49:11 -0700 (PDT)
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
        by cmsmtp with ESMTP
        id dkSuoL4PzSp39e6xloAsAf; Fri, 30 Sep 2022 03:45:21 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
        by cmsmtp with ESMTP
        id e6xkoP3f2Adame6xkoy0Wt; Fri, 30 Sep 2022 03:45:21 +0000
X-Authority-Analysis: v=2.4 cv=YdGuWidf c=1 sm=1 tr=0 ts=63366651
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=xOM3xZuef0cA:10 a=M51BFTxLslgA:10 a=nlC_4_pT8q9DhB4Ho9EA:9
 a=OnIXDKW1BvDk6NnU-rsA:9 a=QEXdDO2ut3YA:10
Received: from CLUIJ (cluij.tuyoix.net [192.168.144.15])
        (authenticated bits=0)
        by fanir.tuyoix.net (8.17.1/8.17.1) with ESMTPSA id 28U3jJDC017664
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 29 Sep 2022 21:45:19 -0600
Date:   Thu, 29 Sep 2022 21:45:04 -0600 (Mountain Daylight Time)
From:   =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To:     "Theodore Ts'o" <tytso@mit.edu>
cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Register ext[23] support only after successful
 ext4 registration
In-Reply-To: <YzWpv8ZKJ7BrOBsg@mit.edu>
Message-ID: <alpine.WNT.2.20.2209292143240.4648@CLUIJ>
References: <7ef87cdb-0d0b-2488-6f42-a670a6454630@tuyoix.net> <YzWpv8ZKJ7BrOBsg@mit.edu>
User-Agent: Alpine 2.20 (WNT 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="119071-31548-1664509505=:4648"
X-CMAE-Envelope: MS4xfM1fWbX60zC4cdcUcgV6kRxMbIaJ5wa/SSsZPXwEFlXHYSF3p8DSYgHs0qNdJAApkxAZPhri8E7aixqIh9mNkkovAXnMJjdjVZPV+OHEOSe9LIxIJiNS
 b3jcGNnPjMfmt7Ie92Z8tAISuFK+YaqnWvkbdv2ubkS0YhvSiw/S1gh0Bayz9YLq13naT2WSSrYNB31N4DPEv7BVZdp4l9NKZ0NMRFtoONVA+afxBXtDGYHA
 wjyjHcAN/fMshJ5jCBmlCkvKvV6gr/nPf30YFFD7mz0E+8xPpnoblVhIIS4f36YA
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--119071-31548-1664509505=:4648
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 29 Sep 2022, Theodore Ts'o wrote:
> On Wed, Aug 10, 2022 at 02:20:45PM -0600, Marc Aurèle La France wrote:
>> Register ext4 as a "replacement" for ext2 and ext3 only after ext4 itself has
>> been successfully registered.  As a side effect, this allows
>> unregister_as_ext[23]() to be inlined.

> The corrent ordering is deliberate; it allows file systems that have
> ext2 and ext3 only file system features will be reported as using ext2
> and ext3 in /proc/mounts.  This doesn't matter quite as much, but it
> could potentially break userspace if a legacy file system that only
> has ext2 file system features is mounted and reported as ext4.

> So sorry, I can't take this change.

Fair enough.  Thanks for responding.

Marc.
--119071-31548-1664509505=:4648--
