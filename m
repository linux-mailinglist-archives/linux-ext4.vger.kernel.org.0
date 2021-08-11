Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D910F3E96E0
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Aug 2021 19:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhHKReJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Aug 2021 13:34:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229484AbhHKReI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 11 Aug 2021 13:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628703224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sn996wyP1762RVthxVYilsh2trpZDoQDtSXbn8LQEl0=;
        b=HXUPMi8Sqm3mbvbkeA/BOdhv1uilXxM6FviNXZRXlqXN8uJcUTw7ptwfyfecv5+KvJ/7Kp
        qb71/zGK5ZV5so/jDHLUXbVRrLtpiPatAL2ss+lLxyrUOg9fr5hQA2U+LDPXX+UDUaYtrx
        ievQpB9lpQ3erJxzfbsa/ONi5HgW5aM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-EUH6_ZzyNqW1tLQO1_bJuQ-1; Wed, 11 Aug 2021 13:33:43 -0400
X-MC-Unique: EUH6_ZzyNqW1tLQO1_bJuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 669BF824F8C;
        Wed, 11 Aug 2021 17:33:42 +0000 (UTC)
Received: from work (unknown [10.40.192.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 90E92781E7;
        Wed, 11 Aug 2021 17:33:41 +0000 (UTC)
Date:   Wed, 11 Aug 2021 19:33:38 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/7] e2fsck: value stored to err is never read
Message-ID: <20210811173338.ikxkrprvdo345zef@work>
References: <20210806095820.83731-1-lczerner@redhat.com>
 <YRKUMP51280FXK7F@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRKUMP51280FXK7F@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 10, 2021 at 10:58:56AM -0400, Theodore Ts'o wrote:
> On Fri, Aug 06, 2021 at 11:58:14AM +0200, Lukas Czerner wrote:
> > Remove it to silence clang warning.
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> 
> Applied, thanks.
> 
> Note that we try to keep e2fsck/recovery.c and fs/jbd2/recovery.c in
> sync, so it's appreciated patches sent to e2fsck/recovery.c or
> fs/jbd2/recovery.c is sent to the other.  I can take care of it in
> this case.
> 
> Cheers,
> 
> 					- Ted

Allright, I'll keep that in mind for the next time.

Thanks!
-Lukas

