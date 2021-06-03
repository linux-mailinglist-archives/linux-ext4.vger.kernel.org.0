Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2221339A9A2
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Jun 2021 20:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFCSCH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Jun 2021 14:02:07 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33137 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229695AbhFCSCH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Jun 2021 14:02:07 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 153I0HR7000941
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Jun 2021 14:00:17 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 43CF515C3CAF; Thu,  3 Jun 2021 14:00:17 -0400 (EDT)
Date:   Thu, 3 Jun 2021 14:00:17 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 1/3] ext4: add discard/zeroout flags to journal flush
Message-ID: <YLkYseB2vSst3aMg@mit.edu>
References: <20210518151327.130198-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518151327.130198-1-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 18, 2021 at 03:13:25PM +0000, Leah Rumancik wrote:
> Add a flags argument to jbd2_journal_flush to enable discarding or
> zero-filling the journal blocks while flushing the journal.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>

Thanks, I've applied this series.

					- Ted
