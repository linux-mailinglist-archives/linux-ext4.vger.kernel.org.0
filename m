Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 854101E700
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2019 04:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEOC7S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 14 May 2019 22:59:18 -0400
Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:10888 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbfEOC7S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 May 2019 22:59:18 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AWAACO3/JbAKWMfQENVQ4LAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBBwEBAQEBAYFlhBODeIJek0OZMIR5AoQPOBIBAwEBAgEBAhABNIYNAQE?=
 =?us-ascii?q?BAyNWEAsNCwICJgICVwYBDQWDIahZcIEvGoUmhFyBC4Fzil4/gREnH4JMhF4BA?=
 =?us-ascii?q?R6DBDGCBCICkAWPagcCghoEjyGBWIUIgxEDhwmZc4F2MxoubwGCQZAgSmIBjB2?=
 =?us-ascii?q?CPgEB?=
Received: from unknown (HELO [10.135.5.170]) ([1.125.140.165])
  by ipmail03.adl6.internode.on.net with ESMTP; 15 May 2019 12:29:14 +0930
Date:   Wed, 15 May 2019 12:29:10 +0930
User-Agent: K-9 Mail for Android
In-Reply-To: <850EDDE2-5B82-4354-AF1C-A2D0B8571093@internode.on.net>
References: <48BA4A6E-5E2A-478E-A96E-A31FA959964C@internode.on.net> <CAFLxGvwnKKHOnM2w8i9hn7LTVYKh5PQP2zYMBmma2k9z7HBpzw@mail.gmail.com> <20190511220659.GB8507@mit.edu> <09D87554-6795-4AEA-B8D0-FEBCB45673A9@internode.on.net> <850EDDE2-5B82-4354-AF1C-A2D0B8571093@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: ext3/ext4 filesystem corruption under post 5.1.0 kernels
To:     Theodore Ts'o <tytso@mit.edu>,
        Richard Weinberger <richard.weinberger@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org
From:   Arthur Marsh <arthur.marsh@internode.on.net>
Message-ID: <17C30FA3-1AB3-4DAD-9B86-9FA9088F11C9@internode.on.net>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 14 May 2019 11:29:37 am ACST, Arthur Marsh <arthur.marsh@internode.on.net> wrote:
>Apologies, I had forgotten to
>
>git bisect - - hard origin/master
>
>I am still seeing the corruption leading to the invalid block error on
>5.1.0+ kernels on both my machines.
>
>Arthur. 

After the mm commits, the 32 bit kernel on Pentium-D still exhibits the "invalid block" issue when running git gc on the kernel source. 

The 64 bit kernel on Athlon II X4 640 has since the mm commits had less problems running git gc on the kernel source but had an "invalid block" error after a second run of git gc. 

Arthur. 

Arthur. 
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
