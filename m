Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4666D1C071
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2019 03:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfENB7n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 13 May 2019 21:59:43 -0400
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:11452 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbfENB7n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 13 May 2019 21:59:43 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2C/AADh299ZAOaJfQENUQ4LAQEBAQEBAQEBAQEHAQEBAQGJUIMql3uYY4VFAoUWAQIBAQEBAQIPATSFbQIBAyNWEAsNDQImAgJXBgENtSprgiciixoBAQEBAQEBAQEBAQEBAQEBAQEBAQEdgQ6CH4NYghULgnSEZQEBHoMTL4ISIAWSVo5ugi6UNwEYhXSDcYcXlySBZTIhMGUBhktPigiCNQEBAQ
Received: from unknown (HELO [10.135.5.170]) ([1.125.137.230])
  by ipmail06.adl2.internode.on.net with ESMTP; 14 May 2019 11:29:41 +0930
Date:   Tue, 14 May 2019 11:29:37 +0930
User-Agent: K-9 Mail for Android
In-Reply-To: <09D87554-6795-4AEA-B8D0-FEBCB45673A9@internode.on.net>
References: <48BA4A6E-5E2A-478E-A96E-A31FA959964C@internode.on.net> <CAFLxGvwnKKHOnM2w8i9hn7LTVYKh5PQP2zYMBmma2k9z7HBpzw@mail.gmail.com> <20190511220659.GB8507@mit.edu> <09D87554-6795-4AEA-B8D0-FEBCB45673A9@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: ext3/ext4 filesystem corruption under post 5.1.0 kernels
To:     Theodore Ts'o <tytso@mit.edu>,
        Richard Weinberger <richard.weinberger@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org
From:   Arthur Marsh <arthur.marsh@internode.on.net>
Message-ID: <850EDDE2-5B82-4354-AF1C-A2D0B8571093@internode.on.net>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Apologies, I had forgotten to

got bisect - - hard origin/master

I am still seeing the corruption leading to the invalid block error on 5.1.0+ kernels on both my machines.

Arthur. 
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
