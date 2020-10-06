Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF81284A58
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Oct 2020 12:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgJFKd2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Oct 2020 06:33:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:57004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJFKd2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 6 Oct 2020 06:33:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E45A0AED8;
        Tue,  6 Oct 2020 10:33:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5342F1E1305; Tue,  6 Oct 2020 12:33:26 +0200 (CEST)
Date:   Tue, 6 Oct 2020 12:33:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     =?utf-8?B?5bi45Yek5qWg?= <changfengnan@qq.com>
Cc:     tytso <tytso@mit.edu>, jack <jack@suse.com>,
        adilger <adilger@dilger.ca>,
        "darrick.wong" <darrick.wong@oracle.com>,
        Fengnan Chang <changfengnan@hikvision.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2] jbd2: avoid transaction reuse after reformatting
Message-ID: <20201006103326.GA6984@quack2.suse.cz>
References: <tencent_84E12D61F93979D8E588E980751B80B40B08@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_84E12D61F93979D8E588E980751B80B40B08@qq.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 03-10-20 14:30:24, 常凤楠 wrote:
> When format ext4 with lazy_journal_init=1, the previous transaction is still on disk,
> it is possible that the previous transaction will be used again during jbd2 recovery.
> Because the seed is changed, the CRC check will fail.
> 
> Signed-off-by: Fengnan Chang <changfengnan@hikvision.com&gt;

I've submitted v3 of the patch [1] which should not be mangled as this one...

								Honza

[1] https://lore.kernel.org/linux-ext4/20201006103154.7130-1-jack@suse.cz

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
