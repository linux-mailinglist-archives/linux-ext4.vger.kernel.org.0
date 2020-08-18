Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E433248DF5
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Aug 2020 20:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHRS2H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Aug 2020 14:28:07 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47670 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726435AbgHRS2F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Aug 2020 14:28:05 -0400
Received: from callcc.thunk.org (pool-108-49-65-20.bstnma.fios.verizon.net [108.49.65.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07IIRpt9017714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 14:27:52 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AA3A5420DC0; Tue, 18 Aug 2020 14:27:51 -0400 (EDT)
Date:   Tue, 18 Aug 2020 14:27:51 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, riteshh@linux.ibm.com
Subject: Re: [PATCH] ext4: change to use fallthrough macro instead of
 fallthrough comments
Message-ID: <20200818182751.GB162457@mit.edu>
References: <20200810114435.24182-1-luoshijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810114435.24182-1-luoshijie1@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 10, 2020 at 07:44:35AM -0400, Shijie Luo wrote:
> Change to use fallthrough macro in switch case.
> 
> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>

Applied, thanks.

					- Ted
