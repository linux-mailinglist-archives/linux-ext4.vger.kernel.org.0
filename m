Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E807E1B41B
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2019 12:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfEMKbP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 13 May 2019 06:31:15 -0400
Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:18084 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728536AbfEMKbP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 13 May 2019 06:31:15 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AFAACO3/JbAKmCfQENVQ4LAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBBwEBAQEBAYFUAQEBAQEBCwGICoJekx6Xb4FmhHkChA83Bg0BAwEBAgE?=
 =?us-ascii?q?BAhABNIYNAgEDI1YQCw0NAiYCAlcGAQ2DJqhZcIEvGoUmhFyBC4Fzil4/gTgME?=
 =?us-ascii?q?4JMhF4BAQcXgwQxggQiApAFj2oHAoIaBI8hgUkBDoUIgxEDhwmZcoF3MxoubwG?=
 =?us-ascii?q?CQpAfSo0Agj4BAQ?=
Received: from unknown (HELO [10.135.5.170]) ([1.125.130.169])
  by ipmail03.adl6.internode.on.net with ESMTP; 13 May 2019 20:01:11 +0930
Date:   Mon, 13 May 2019 20:01:07 +0930
User-Agent: K-9 Mail for Android
In-Reply-To: <20190511220659.GB8507@mit.edu>
References: <48BA4A6E-5E2A-478E-A96E-A31FA959964C@internode.on.net> <CAFLxGvwnKKHOnM2w8i9hn7LTVYKh5PQP2zYMBmma2k9z7HBpzw@mail.gmail.com> <20190511220659.GB8507@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: ext3/ext4 filesystem corruption under post 5.1.0 kernels
To:     Theodore Ts'o <tytso@mit.edu>,
        Richard Weinberger <richard.weinberger@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org
From:   Arthur Marsh <arthur.marsh@internode.on.net>
Message-ID: <09D87554-6795-4AEA-B8D0-FEBCB45673A9@internode.on.net>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

After a git bisect reset and updating to the current Linus git head, the problem no longer occurs.

Thanks for the feedback on the problem that I experienced.

Arthur. 
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
