Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33334248DF3
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Aug 2020 20:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgHRS0U (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Aug 2020 14:26:20 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47320 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726570AbgHRS0U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Aug 2020 14:26:20 -0400
Received: from callcc.thunk.org (pool-108-49-65-20.bstnma.fios.verizon.net [108.49.65.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07IIQGpa017009
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 14:26:16 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 38C89420DC0; Tue, 18 Aug 2020 14:26:16 -0400 (EDT)
Date:   Tue, 18 Aug 2020 14:26:16 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Kyoungho Koo <rnrudgh@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: remove unused parameter of
 ext4_generic_delete_entry function
Message-ID: <20200818182616.GA162457@mit.edu>
References: <20200810080701.GA14160@koo-Z370-HD3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810080701.GA14160@koo-Z370-HD3>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 10, 2020 at 05:07:05PM +0900, Kyoungho Koo wrote:
> The ext4_generic_delete_entry function defines the handle_t type
> variable, handle, as a parameter, but it is not used.
> 
> Signed-off-by: Kyoungho Koo <rnrudgh@gmail.com>

Applied, thanks.

					- Ted
