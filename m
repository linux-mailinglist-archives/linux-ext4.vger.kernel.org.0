Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65C525F3EE
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Sep 2020 09:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgIGH1Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 7 Sep 2020 03:27:16 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:55333 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgIGH1P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Sep 2020 03:27:15 -0400
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 30AE920000D;
        Mon,  7 Sep 2020 07:27:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <E65D3B4E-A8C4-4BC8-9A6C-07E900F90D9A@dilger.ca>
References: <20200717100846.497546-1-antoine.tenart@bootlin.com> <B2EE7AC5-BEC0-46A8-8C37-D3085645F94C@dilger.ca> <159609406998.3391.5621985067917886015@kwain> <159920782384.787733.9857416604675445355@kwain> <E65D3B4E-A8C4-4BC8-9A6C-07E900F90D9A@dilger.ca>
Subject: Re: [PATCH v2] create_inode: set xattrs to the root directory as well
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        matthew.weber@rockwellcollins.com, thomas.petazzoni@bootlin.com
From:   Antoine Tenart <antoine.tenart@bootlin.com>
Message-ID: <159946362909.787733.4975683171769234991@kwain>
Date:   Mon, 07 Sep 2020 09:27:09 +0200
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Andreas,

Quoting Andreas Dilger (2020-09-04 21:43:18)
> On Sep 4, 2020, at 2:23 AM, Antoine Tenart <antoine.tenart@bootlin.com> wrote:
> > Quoting Antoine Tenart (2020-07-30 09:27:50)
> >> 
> >> Gentle ping. What's the status of this patch?
> > 
> > Do anyone know if anything else is required to get this merged?
> 
> Based on other emails to the list, Ted has a backlog of patches to be
> merged for ext4 and e2fsprogs, so it isn't that your patch was missed.
> He will hopefully be able to start landing patches again soon.

Thanks for the explanation!

Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
