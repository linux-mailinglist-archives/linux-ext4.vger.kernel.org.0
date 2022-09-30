Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9C65F1208
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Sep 2022 20:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiI3S7e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Sep 2022 14:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiI3S7e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Sep 2022 14:59:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9582A635A
        for <linux-ext4@vger.kernel.org>; Fri, 30 Sep 2022 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9dj1jhAGMTHN2/6AAUKuXgSvGwSMSEl8zR34eq2mx8g=; b=G5nVp/66wxO6RY4OPbTB8ro8ff
        gxnb9x2yKBAzjtghAJ7lq/fByquHHvpCvqpNpeNqmEG5umHbTCjqc5QGywcrt4vF1A+GhThAh6fVg
        AU9qNXKUUHQPHNwjSeGKcK2zbqwwGlYnnNq7uLBwm4UycPBvyr3Nl3wTbtTn8L/HQhiXJE0dUCVwp
        qmoPMHUo28tmmJt5ckwceCOVoTkB0XqEcH2XafmmA4dSyMH1v1yC0jd27HDVmbPFdzIhzwLB97jYa
        6mJpn81Ukz2nzbU6ewpfAMMlJDZS6Gaz72GYmAPHDGNTYBhYPfAmGvtSSggCa0XEEP3dIvd1z6UIA
        01dB9/dw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oeLEC-00ETvN-Jb; Fri, 30 Sep 2022 18:59:16 +0000
Date:   Fri, 30 Sep 2022 19:59:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Zorro Lang <zlang@kernel.org>, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [Bug report] BUG: Kernel NULL pointer dereference at 0x00000069,
 filemap_release_folio+0x88/0xb0
Message-ID: <Yzc8hJL6cqxXCKaJ@casper.infradead.org>
References: <20220927011720.7jmugevxc7ax26qw@zlang-mailbox>
 <YzYN4JqbKdxLd6oA@casper.infradead.org>
 <87wn9lei2x.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn9lei2x.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 30, 2022 at 12:01:26PM +1000, Michael Ellerman wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> >> [ 4681.238745] Instruction dump: 
> >> [ 4681.238749] fbc1fff0 f821ffc1 7c7d1b78 7c9c2378 ebc30028 7fdff378 48000018 60000000  
> >> [ 4681.238765] 60000000 ebff0008 7c3ef840 41820048 <815f0060> e93f0000 5529077c 7d295378  
> >
> > Running that through scripts/decodecode (with some minor hacks .. how
> > do PPC people do this properly?)
> 
> We've just always used our own scripts. Mine is here: https://github.com/mpe/misc-scripts/blob/master/ppc/ppc-disasm
> 
> I've added an issue to our tracker for us to get scripts/decodecode
> working on our oopses (eventually).

Would you be open to changing your oops printer to do
s/Instruction dump/Code/ ?  That would make it work without any other
changes.

$ CROSS_COMPILE=powerpc-linux-gnu- ./scripts/decodecode
Code:
fbc1fff0 f821ffc1 7c7d1b78 7c9c2378 ebc30028 7fdff378 48000018 60000000
60000000 ebff0008 7c3ef840 41820048 <815f0060> e93f0000 5529077c 7d295378
^D

gives the right answer.  You could also do like x86 and put Code: on
the same line as the first set of hex (not that it matters; the parser
is fairly flexible).  This would also work ...

diff --git a/scripts/decodecode b/scripts/decodecode
index c711a196511c..0cadf1a37cbf 100755
--- a/scripts/decodecode
+++ b/scripts/decodecode
@@ -27,8 +27,8 @@ cont=
 while read i ; do
 
 case "$i" in
-*Code:*)
-       code=$i
+*Code:* | *'Instruction dump':*)
+       code=${i##*:}
        cont=yes
        ;;
 *)
@@ -51,7 +51,7 @@ if [ -z "$code" ]; then
 fi
 
 echo $code
-code=`echo $code | sed -e 's/.*Code: //'`
+code=`echo $code`
 
 width=`expr index "$code" ' '`
 width=$((($width-1)/2))

(no, i don't know why i need that echo $code line; trimming trailing
spaces, maybe? shell is a terrible language)

> $ ./scripts/faddr2line .build/vmlinux drop_buffers.constprop.0+0x4c
> drop_buffers.constprop.0+0x4c/0x170:
> arch_atomic_read at arch/powerpc/include/asm/atomic.h:30
> (inlined by) atomic_read at include/linux/atomic/atomic-instrumented.h:28
> (inlined by) buffer_busy at fs/buffer.c:2859
> (inlined by) drop_buffers at fs/buffer.c:2871
> 
> static inline int buffer_busy(struct buffer_head *bh)
> {
> 	return atomic_read(&bh->b_count) |
> 		(bh->b_state & ((1 << BH_Dirty) | (1 << BH_Lock)));
> }
> 
> struct folio {
>         union {
>                 struct {
>                         long unsigned int flags;         /*     0     8 */
>                         union {
>                                 struct list_head lru;    /*     8    16 */
>                                 struct {
>                                         void * __filler; /*     8     8 */
>                                         unsigned int mlock_count; /*    16     4 */
>                                 };                       /*     8    16 */
>                         };                               /*     8    16 */
>                         struct address_space * mapping;  /*    24     8 */
>                         long unsigned int index;         /*    32     8 */
>                         void *     private;              /*    40     8 */      <----
> 
> struct buffer_head {
>         long unsigned int          b_state;              /*     0     8 */
>         struct buffer_head *       b_this_page;          /*     8     8 */
>         struct page *              b_page;               /*    16     8 */
>         sector_t                   b_blocknr;            /*    24     8 */
>         size_t                     b_size;               /*    32     8 */
>         char *                     b_data;               /*    40     8 */
>         struct block_device *      b_bdev;               /*    48     8 */
>         bh_end_io_t *              b_end_io;             /*    56     8 */
>         void *                     b_private;            /*    64     8 */
>         struct list_head           b_assoc_buffers;      /*    72    16 */
>         struct address_space *     b_assoc_map;          /*    88     8 */
>         atomic_t                   b_count;              /*    96     4 */      <----
> 
> The buffer_head comes from folio_buffers(folio):
> 
> static bool
> drop_buffers(struct folio *folio, struct buffer_head **buffers_to_free)
> {
> 	struct buffer_head *head = folio_buffers(folio);
> 
> Which is == folio_get_private()
> 
> r3 and r29 still hold folio = c00c00000042f1c0 
> 
> That's a valid looking vmemmap address.
> 
> So we have a valid folio, but its private field == 9 ?
> 
> Seems like all sorts of things get stuffed into page->private, so
> presumably 9 is not necessarily a corrupt value, just not what we're
> expecting. But I'm out of my depth so over to you :)

Yes, all kinds of things do get stuffed into folio->private, alas.
However, for an ext4 folio, it should either be NULL or a pointer to
a buffer_head.  It'd be interesting to insert ...

	if ((long)head < 4096) dump_page(&folio->page, "bad bh");

in drop_buffers() before we actually dereference the 'head'.

My suspicion is that page->private and PagePrivate have got out of sync
somehow; we're trying to reclaim the PG_private bit and there have been
some similar problems of this type in the past.

I had success debugging this kind of problem with this patch:

commit 80eba374eab3
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Tue Jun 21 07:04:32 2022 -0400

    mm: Add an assertion that PG_private and folio->private are in sync
    
    We are trying to eliminate the use of the PG_private flag.  To do so,
    it must be in sync with the use of the ->private field.  It usually
    is, and this assert should catch any cases where it isn't.
    
    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/mm/filemap.c b/mm/filemap.c
index 15800334147b..2f26c32ea1cd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1529,6 +1529,9 @@ void folio_unlock(struct folio *folio)
 	BUILD_BUG_ON(PG_waiters != 7);
 	BUILD_BUG_ON(PG_locked > 7);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_BUG_ON_FOLIO(!folio_test_swapbacked(folio) &&
+			(folio_test_private(folio) ==
+			 !folio_get_private(folio)), folio);
 	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio, 0)))
 		folio_wake_bit(folio, PG_locked);
 }
