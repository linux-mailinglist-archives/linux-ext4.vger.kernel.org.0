Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996345E7DA8
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Sep 2022 16:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIWOyk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Sep 2022 10:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiIWOyj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Sep 2022 10:54:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1272212AD2
        for <linux-ext4@vger.kernel.org>; Fri, 23 Sep 2022 07:54:35 -0700 (PDT)
Received: from localhost (modemcable141.102-20-96.mc.videotron.ca [96.20.102.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: krisman)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 701A56601A13;
        Fri, 23 Sep 2022 15:54:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663944873;
        bh=oSdWFo0TscxfH7/kryYWf5ZQo2F7LY5OWzR2xISGo9w=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WNjGZKdT+M9PcqqJxrCNAJrQTPs4i4+VQIUc+vBcj4TMRSXSBSkq1frL2Fd4LFHTk
         wwAbTAkKaOAi0u7eXxRYA9uJeiccIM8Sbo61ytJIayx2c5ebmjqWT/eMcFWgzajb3V
         Ha3S/cetujV9Bx+FReOgHj8awhUVT5PFeI+ynW8asJCyeqjbcEd8JFkw8NrGK4FcE4
         f9iqPcsW39b+9HhGaHDC8OAQ6WTw01EZRqTXxlvyTc/FcTtUPS71AGwb5G70VrBRKd
         GjByrtxuJQVQEsKgsWKMdwNe4dRQ6Cvf51hEUEGJ5SVYJqzKPh0cIsxLj8iqZzd5bY
         K1xh0W6XyDf2w==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v9 0/8] Clean up the case-insensitive lookup path
Organization: Collabora
References: <20220913234150.513075-1-krisman@collabora.com>
        <Yy0t8WYhM+Dv3gX1@sol.localdomain>
Date:   Fri, 23 Sep 2022 10:54:30 -0400
In-Reply-To: <Yy0t8WYhM+Dv3gX1@sol.localdomain> (Eric Biggers's message of
        "Thu, 22 Sep 2022 20:54:25 -0700")
Message-ID: <87fsgi2lax.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Tue, Sep 13, 2022 at 07:41:42PM -0400, Gabriel Krisman Bertazi wrote:
>> Hi,
>> 
>> I'm resubmitting this as v9 since I think it has fallen through the
>> cracks :).  It is a collection of trivial fixes for casefold support on
>> ext4/f2fs. More details below.
>> 
>> It has been sitting on the list for a while and most of it is r-b
>> already. I'm keeping the tags for this submission, since there is no
>> modifications from previous submissions, apart from a minor conflict
>> resolution when merging to linus/master.
>
> Who are you expecting to apply this?

Hi Eric,

There are three groups of changes here: libfs, ext4 and f2fs.  Since the
changes in libfs are self-contained and only affect these two
filesystems, I think it should be fine for them to go through a fs tree.

The bulk of changes are ext4, and Ted mentioned on an earlier version
that he could pick the first patches of this series, so I'm thinking it
should all go through the ext4 tree.  If Jaegeuk acks, the f2fs changes
are safe to go with the rest, or I can send them afterwards as a
separate series once the libfs code is merged.

Thanks,

-- 
Gabriel Krisman Bertazi
