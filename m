Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4273355729
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Apr 2021 17:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345382AbhDFPCE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Apr 2021 11:02:04 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38778 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1345380AbhDFPCE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Apr 2021 11:02:04 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 136F1e21013214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Apr 2021 11:01:40 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F1C1E15C3B0C; Tue,  6 Apr 2021 11:01:39 -0400 (EDT)
Date:   Tue, 6 Apr 2021 11:01:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Hao Sun <sunhao.th@gmail.com>, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: KCSAN: data-race in __jbd2_journal_file_buffer /
 jbd2_journal_dirty_metadata
Message-ID: <YGx308zQXxOjmwNZ@mit.edu>
References: <CACkBjsZW5Sp4jB51+C5mrMssgq73x8iEko_EV6CTXVvtVa7KPQ@mail.gmail.com>
 <20210406123232.GD19407@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406123232.GD19407@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 06, 2021 at 02:32:33PM +0200, Jan Kara wrote:
> And the comment explains, why we do this unreliable check. Again, if we
> wanted to silence KCSAN, we could use data_race() macro but AFAIU Ted isn't
> very fond of that annotation.

I'm not fond of the data_race macro, but I like bogus KCSAN reports
even less.  My main complaint is if we're going to have to put the
data_race() macro in place, we're going to need to annotate each
location with an explanation of why it's there (suppress a KCSAN false
positive), and why's it's safe.  If it's only one or two places, it'll
probably be fine.  If it's dozens, then I would say that KCSAN is
becoming a net negative in terms of making the Linux kernel code
maintainable.

						- Ted
