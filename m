Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1637D413DE8
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Sep 2021 01:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhIUXTj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Sep 2021 19:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhIUXTj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Sep 2021 19:19:39 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B674C061574;
        Tue, 21 Sep 2021 16:18:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4B44937B;
        Tue, 21 Sep 2021 23:18:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4B44937B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1632266287; bh=mf0KOo3ckLgLF2xp4Atdjuf2Zv+WYRw9Ib3vZUan8eg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lO0YHeqW1w8s/Pg9atLuXcSU1xX0RkfIxladUKapW/sOBjInYFXRrwiHCoNdkSDLr
         wFWsLmFHbXkErZd8kwFtequp0VsoALal3sxJZAlzPowiKLo5F9OQj/yFZL3h9kCl7y
         mrype6ytEXI+PMOoaW8wJtPT9HNmw9dL9BB1mYV89gxfpr6q5ScLrXWhcfk/E6JFP7
         kLB39WExo53vtTLW8rtoedv7TPxQld/WF0HP21b9/fqTo5M/7+7N0zxkVVa8Y5T/Rg
         NYTcOF5UFPLDw2kPkPGPB2of2zTIfrsB213dk4qrJ+pWW/fk8CzJItuC12ed//0CO2
         dOop7seSRrcIg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jan Kara <jack@suse.cz>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4: docs: switch away from list-table
In-Reply-To: <20210916095455.GE10610@quack2.suse.cz>
References: <20210902220854.198850-1-corbet@lwn.net>
 <20210902220854.198850-2-corbet@lwn.net>
 <20210916095455.GE10610@quack2.suse.cz>
Date:   Tue, 21 Sep 2021 17:18:06 -0600
Message-ID: <877df9tt5d.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> On Thu 02-09-21 16:08:53, Jonathan Corbet wrote:
>> Commit 3a6541e97c03 (Add documentation about the orphan file feature) added
>> a new document on orphan files, which is great.  But the use of
>> "list-table" results in documents that are absolutely unreadable in their
>> plain-text form.  Switch this file to the regular RST table format instead;
>> the rendered (HTML) output is identical.
>> 
>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>
> Thanks! Definitely looks more readable :). You can add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks for having a look!  I'll ahead and apply these, then.

jon
