Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F4F3EC350
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Aug 2021 16:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbhHNObQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Aug 2021 10:31:16 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54746 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229924AbhHNObP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Aug 2021 10:31:15 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17EEUgCD022130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Aug 2021 10:30:42 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0CDCE15C37C1; Sat, 14 Aug 2021 10:30:42 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Make sure quota files are not grabbed accidentally
Date:   Sat, 14 Aug 2021 10:30:40 -0400
Message-Id: <162895142787.478912.3806588086950886434.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210812133122.26360-1-jack@suse.cz>
References: <20210812133122.26360-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 12 Aug 2021 15:31:22 +0200, Jan Kara wrote:
> If ext4 filesystem is corrupted so that quota files are linked from
> directory hirerarchy, bad things can happen. E.g. quota files can get
> corrupted or deleted. Make sure we are not grabbing quota file inodes
> when we expect normal inodes.
> 
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: Make sure quota files are not grabbed accidentally
      commit: d7d6785de00f5b576c8b370331e2ca18259d3797

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
