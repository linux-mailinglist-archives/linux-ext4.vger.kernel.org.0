Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7822BDF7BB
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 23:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfJUVtI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 17:49:08 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40070 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726672AbfJUVtH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 17:49:07 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9LLn08o000554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 17:49:02 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 747B1420456; Mon, 21 Oct 2019 17:48:59 -0400 (EDT)
Date:   Mon, 21 Oct 2019 17:48:59 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 19/22] jbd2: Rename h_buffer_credits to h_total_credits
Message-ID: <20191021214859.GD24015@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-19-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003220613.10791-19-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 04, 2019 at 12:06:05AM +0200, Jan Kara wrote:
> The credit counter now contains both buffer and revoke descriptor block
> credits. Rename to counter to h_total_credits to reflect that. No
> functional change.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks fine, feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

