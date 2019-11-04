Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A50EEDDA6
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 12:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfKDLWe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Nov 2019 06:22:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:56716 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbfKDLWe (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 4 Nov 2019 06:22:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D572BB301;
        Mon,  4 Nov 2019 11:22:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5E9451E43DA; Mon,  4 Nov 2019 12:22:32 +0100 (CET)
Date:   Mon, 4 Nov 2019 12:22:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/19 v3] ext4: Fix transaction overflow due to revoke
 descriptors
Message-ID: <20191104112232.GD22379@quack2.suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191104033252.GC12046@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104033252.GC12046@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted!

On Sun 03-11-19 22:32:52, Theodore Y. Ts'o wrote:
> I believe that I'm waiting for the v4 version of this series with some
> pending fixes that you are planning on making.  Is that correct?

Ah, good that you pinged me because I have the series ready but I was
waiting for your answers to some explanations... In particular discussion
around patch 3 (move iput() outside of transaction), patch 15 (dropping of
j_state_lock around t_tid load), patch 18 (possible large overreservation
of descriptor blocks due to rounding), and 21 (change of on-disk format for
revoke descriptors).

Out of these I probably find the overreservation due to rounding the most
serious and easy enough to handle so I'll fix that and then resend the
series unless you raise your objection also in some other case.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
