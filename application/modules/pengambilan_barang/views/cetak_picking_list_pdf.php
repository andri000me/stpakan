<?php
$image_file = base_url() . "assets/images/feedmill_logo.png";
$no_order = isset($items [0] ['no_order']) ? strtoupper($items [0] ['no_order']) : '';
$farm = isset($items [0] ['farm']) ? strtoupper($items [0] ['farm']) : '';
$tanggal_kirim = isset($items [0] ['tgl_kirim']) ? convert_month($items [0] ['tgl_kirim'], 1) : '';

    $tanggal_kebutuhan = '';
    if(isset($items[0]['tgl_keb_awal'])){
        if($grup_farm == 'brd'){
            $tanggal_kebutuhan = convert_month($items[0]['tgl_keb_awal'], 1) . ' s/d ' . convert_month($items[0]['tgl_keb_akhir'], 1);
        }
        else{
            $tanggal_kebutuhan = convert_month($items[0]['tgl_keb_awal'], 1);
        }
    }

echo '
	<table width="100%" style="font-family:Arial">
		<tr>
			<td style="width:8%"><img src="' . $image_file . '" alt="test alt attribute" border="0" /></td>
			<td style="width:92%">
				<span style="font-weight:bold;font-size:8px;">PT. WONOKOYO JAYA CORPORINDO</span><br>
				<span style="font-weight:bold;font-size:6px;">DIVISI FEEDMILL</span><br>
				<span style="font-weight:bold;font-size:6px;">UNIT GEMPOL</span>
			</td>
		</tr>
	</table>	
	<br><br>
	<table width="100%" style="font-family:Arial;font-size:6px;" id="header-barang">
		<tr>
			<td colspan="4" align="center" style="font-size:8px;"><b>Picking List</b></td>
		</tr>
		<tr>
			<td colspan="4" align="center" style="">&nbsp;</td>
		</tr>
		<tr>
			<td align="left" style="width:18%;">No. Pengambilan</td>
			<td align="left" style="width:35%;">&nbsp;:&nbsp;' . $no_order . '</td>
			<td align="left" style="width:18%;">Farm</td>
			<td align="left" style="width:35%;">&nbsp;:&nbsp;' . $farm . '</td>
		</tr>
		<tr>
			<td align="left" style="width:18%;">Tanggal Kebutuhan</td>
			<td align="left" style="width:35%;">&nbsp;:&nbsp;' . $tanggal_kebutuhan . '</td>
			<td align="left" style="width:18%;">Tanggal Pengiriman</td>
			<td align="left" style="width:35%;">&nbsp;:&nbsp;' . $tanggal_kirim . '</td>
		</tr>
		<tr>
			<td colspan="4" align="center" style="">&nbsp;</td>
		</tr>
	</table>
	<br>
	<table width="100%" style="font-family:Arial;font-size:6px;" id="detail-barang">';
	if($grup_farm == 'brd'){
		echo '<tr>
			<th>Kode Kandang</th>
			<th>Jenis Kelamin</th>
			<th>Kavling-Pallet</th>
			<th>Kode Pakan</th>
			<th>Nama Pakan</th>
                            <th>Bentuk</th>
                                            <th>Stok Gudang</th>
                                        <th>Kebutuhan Pakan</th>
                                        <th>Sisa Pakan LHK (sak)</th>
                                        <th>Sisa Pakan Outstanding</th>
                                        <th>Rencana Kirim</th>
			<th>Paraf</th>
		</tr>';
	}
	else{
		echo '<tr>
			<th>Kode Kandang</th>
			<th>Kavling-Pallet</th>
			<th>Nama Pakan</th>
                                        <th>Kebutuhan Pakan</th>
                                        <th>Sisa Pakan LHK (sak)</th>
                                        <th>Sisa Pakan Outstanding</th>
                                        <th>Rencana Kirim</th>
			<th>Paraf</th>
		</tr>';

	}
foreach ($items as $key => $value) {
    if ($value ['keterangan'] == 0) {
    	if($grup_farm == 'brd'){
        	echo '<tr>
					<td>' . $value ['kode_kandang'] . '</td>
					<td>' . $value ['jenis_kelamin'] . '</td>
					<td>' . $value ['kode_pallet'] . '</td>
					<td>' . $value ['kode_barang'] . '</td>
					<td>' . $value ['nama_barang'] . '</td>
					<td>' . $value ['bentuk_pakan'] . '</td>
					<td class="number">' . $value ['jml_stok_gudang'] . '</td>
					<td class="number">' . $value ['kebutuhan_pakan'] . '</td>
					<td class="number">' . $value ['sisa_pakan'] . '</td>
					<td class="number">' . $value ['jml_order_outstanding']/*($value ['kebutuhan_pakan'] - $value ['jumlah'])*/ . '</td>
					<td class="number">' . $value ['jumlah'] . '</td>
					<td></td>
					</tr>';

    	}
    	else{
        	echo '<tr>
					<td>' . $value ['kode_kandang'] . '</td>
					<td>' . $value ['kode_pallet'] . '</td>
					<td>' . $value ['nama_barang'] . '</td>
					<td class="number">' . $value ['kebutuhan_pakan'] . '</td>
					<td class="number">' . $value ['sisa_pakan'] . '</td>
					<td class="number">' . $value ['jml_order_outstanding']/*($value ['kebutuhan_pakan'] - $value ['jumlah'])*/ . '</td>
					<td class="number">' . $value ['jumlah'] . '</td>
					<td></td>
					</tr>';

    	}
    }
}
echo '</table>		
';
?>

<style>
    table#header-barang td {
        height: 10px;
    }

    table#detail-barang {
        border: solid 2px black;
        border-collapse: collapse;
    }

    table#detail-barang tr td {
        height: 10px;
        border: solid 2px black;
        border-collapse: collapse;
        vertical-align: middle;
        text-align: center;
    }

    table#detail-barang tr th {
        height: 15px;
        border: solid 2px black;
        border-collapse: collapse;
        font-weight: bold;
        vertical-align: middle;
        text-align: center;
    }

    .number {
        text-align: right;
    }
</style>