Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FBD243162
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 01:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHLXOF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Aug 2020 19:14:05 -0400
Received: from mail.thelounge.net ([91.118.73.15]:46179 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHLXOE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Aug 2020 19:14:04 -0400
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4BRlrV1MSWzXSR;
        Thu, 13 Aug 2020 01:14:02 +0200 (CEST)
Subject: Re: libext2fs: mkfs.ext3 really slow on centos 8.2
To:     Andreas Dilger <adilger@dilger.ca>,
        Maciej Jablonski <mafjmafj@gmail.com>
Cc:     linux-ext4@vger.kernel.org
References: <CAPQccj4_Tz-11AfXaSiPj4aRWYU2mX9eJuJyGNR68Mini0PZjw@mail.gmail.com>
 <CAPQccj7XwunXerNYxPBTpBa0JVX7vzC=7aBoE8m35ttFHYNOPg@mail.gmail.com>
 <4D72360F-7836-4C4F-920D-4D1BC1DE704E@dilger.ca>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <3cc33ea5-ab63-344e-7251-daa808b855bb@thelounge.net>
Date:   Thu, 13 Aug 2020 01:14:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <4D72360F-7836-4C4F-920D-4D1BC1DE704E@dilger.ca>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



Am 13.08.20 um 00:45 schrieb Andreas Dilger:
> On Aug 10, 2020, at 6:37 AM, Maciej Jablonski <mafjmafj@gmail.com> wrote:
>> On upgrading from centos 7.6 to centos 8.2 mkfs slowed down by orders
>> of magnitude.
>>
>> e.g. 35GB partition from under 8s to 4m+ on the same host.
>>
>> Most time is spent on writing the journal to the disk.
>>
>> strace shows the following:
>>
>> We have got strace which shows that each each block is zeroed with
>> fallocate and each
>> invocation of fallocate takes 10ms, this accumulates of course.
> 
> Do you really need to use mkfs.ext3, or can you use mkfs.ext4 and
> mount the filesystem as type ext4?  Then you can use the "flexbg"
> feature and it will not only speed up mkfs but also many other
> normal operations (e.g. mount, e2fsck, allocation, etc)

typo: it's "flex_bg" and enabled by default (Filesystem created: Sun Aug
 9 13:24:15 2020)

Filesystem features: has_journal ext_attr resize_inode dir_index
filetype needs_recovery extent 64bit flex_bg sparse_super large_file
huge_file dir_nlink extra_isize metadata_csum

ext3 is something of the past for a full decade now
